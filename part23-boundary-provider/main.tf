# data sources
data "boundary_auth_method" "auth_method" {
  name = "password"
}

data "boundary_user" "global_scope_admin" {
  name = "admin"
}
#----------

resource "boundary_scope" "global" {
  global_scope = true
  description  = "highest-level Scope for administrators"
  scope_id     = "global"
}

resource "boundary_scope" "corp" {
  name                     = "DVH"
  description              = "DVH scope"
  scope_id                 = boundary_scope.global.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_scope" "core_infra" {
  name                   = "tf-templates"
  description            = "DVH delivery project"
  scope_id               = boundary_scope.corp.id
  auto_create_admin_role = true
}

## Use password auth method
resource "boundary_auth_method" "password" {
  name     = "DVH Password"
  scope_id = boundary_scope.corp.id
  type     = "password"
}

## users and passwords
resource "boundary_account_password" "client_acct" {
  for_each    = var.clients
  name        = each.keyBOUNDARY_ADDR
  description = "User account for ${each.key}"
  #   type           = "password"
  login_name     = lower(each.key)
  password       = each.value
  auth_method_id = boundary_auth_method.password.id
}
resource "boundary_account_password" "admins_acct" {
  for_each    = var.admins
  name        = "${each.key} account"
  description = "User account for ${each.key}"
  #   type           = "password"
  login_name     = lower(each.key)
  password       = each.value
  auth_method_id = boundary_auth_method.password.id
}

resource "boundary_account_password" "readonly_users_acct" {
  for_each    = var.readonly_users
  name        = each.key
  description = "User account for ${each.key}"
  #   type           = "password"
  login_name     = lower(each.key)
  password       = each.value
  auth_method_id = boundary_auth_method.password.id
}

resource "boundary_user" "clients" {
  for_each    = var.clients
  name        = each.key
  description = "User resource for ${each.key}"
  scope_id    = boundary_scope.corp.id
  account_ids = [boundary_account_password.client_acct[each.key].id]
}
resource "boundary_user" "admins" {
  for_each    = var.admins
  name        = each.key
  description = "User resource for ${each.key}"
  scope_id    = boundary_scope.corp.id
  account_ids = [boundary_account_password.admins_acct[each.key].id]
}
### readonly users
resource "boundary_user" "readonly_users" {
  for_each    = var.readonly_users
  name        = each.key
  description = "User resource for ${each.key}"
  scope_id    = boundary_scope.corp.id
  account_ids = [for account in boundary_account_password.readonly_users_acct : account.id]
}

## groups and roles
resource "boundary_group" "readonly_group" {
  name        = "read-only"
  description = "Organization group for readonly users"
  member_ids  = [for user in boundary_user.readonly_users : user.id]
  scope_id    = boundary_scope.corp.id
}
resource "boundary_group" "clients_group" {
  name        = "clients-group"
  description = "Organization group for regular users"
  member_ids  = [for user in boundary_user.clients : user.id]
  scope_id    = boundary_scope.corp.id
}
resource "boundary_group" "admin_group" {
  name        = "admins-group"
  description = "Organization group for regular users"
  member_ids  = [for user in boundary_user.admins : user.id]
  scope_id    = boundary_scope.corp.id
}

resource "boundary_role" "dvh_readonly" {
  name          = "Read-only"
  description   = "Read-only role"
  principal_ids = [boundary_group.readonly_group.id]
  grant_strings = [var.all_list]
  scope_id      = boundary_scope.core_infra.id
}

resource "boundary_role" "dvh_admin" {
  name          = "admin"
  description   = "Administrator role"
  principal_ids = [boundary_group.admin_group.id]
  grant_strings = [var.all_actions]
  scope_id      = boundary_scope.core_infra.id
}

resource "boundary_role" "dvh_client" {
  name          = "client"
  description   = "client role for mereley connecting through boudary."
  principal_ids = [boundary_group.clients_group.id]
  grant_strings = [var.all_list, var.target_authorize_session, var.auth_method_authenticate]
  scope_id      = boundary_scope.core_infra.id
}


## Main servers Targets configuration
resource "boundary_host_catalog_static" "main_servers" {
  name        = "main_servers"
  description = "main servers host catalog"
  scope_id    = boundary_scope.core_infra.id
}

resource "boundary_host_static" "main_servers" {
  for_each        = var.main_server_ips
  type            = "static"
  name            = "main_server_service_${each.value}"
  description     = "Main server host"
  address         = each.key
  host_catalog_id = boundary_host_catalog_static.main_servers.id
}

resource "boundary_host_set_static" "main_servers_ssh" {
  type            = "static"
  name            = "main_servers_ssh"
  description     = "Host set for main servers"
  host_catalog_id = boundary_host_catalog_static.main_servers.id
  host_ids        = [for host in boundary_host_static.main_servers : host.id]
}


## credential stores
resource "boundary_credential_store_static" "ssh_private_key_store" {
  name     = var.main_cred_store_name
  scope_id = boundary_scope.core_infra.id
}

## Uncomment the following lines if you have vault paid plan
# resource "boundary_credential_store_vault" "vault_cert_store" {
#   name = "vault-cred-store"
#   address  = var.vault_address
#   token    = var.vault_cred_store_token
#   scope_id = boundary_scope.core_infra.id
# }

# resource "boundary_credential_library_vault_ssh_certificate" "vault_cred_lib_ssh" {
#   name                = "certificates-library"
#   credential_store_id = boundary_credential_store_vault.vault_cert_store.id
#   path                = var.vault_sign_path
#   username            = var.vault_username
#   key_type            = "ecdsa"
#   key_bits            = 521
# }

### end of vault ###

resource "boundary_credential_ssh_private_key" "main_server_keys" {
  for_each            = var.ssh_private_key_sources
  name                = each.value
  username            = sensitive(var.ssh_user)
  credential_store_id = boundary_credential_store_static.ssh_private_key_store.id
  private_key         = file(var.ssh_key_path)
}

# ssh target for DVH main servers
resource "boundary_target" "main_servers_ssh" {
  type                           = "tcp"
  for_each                       = var.main_server_names
  name                           = "${each.value}_ssh_server"
  description                    = "Main servers SSH target"
  scope_id                       = boundary_scope.core_infra.id
  brokered_credential_source_ids = [for credential in boundary_credential_ssh_private_key.main_server_keys : credential.id]
  default_port                   = var.ssh_port # change to variable
  
  host_source_ids = [
    boundary_host_set_static.main_servers_ssh.id
  ]
}


#### uncomment the following block if you have pain boundary plan to use cred injection
# resource "boundary_target" "test_server_ssh" {
#   type                           = "tcp"
#   name                           = "${var.test_server_name}_ssh_server"
#   description                    = "test servers SSH target"
#   scope_id                       = boundary_scope.core_infra.id
#   default_port                   = var.ssh_port

#   injected_application_credential_source_ids = [boundary_credential_library_vault_ssh_certificate.vault_cred_lib_ssh.id]

#   host_source_ids = [
#     boundary_host_set_static.main_servers_ssh.id
#   ]
# }
### End of cred injection

# TODO: break resources into seperate tf files