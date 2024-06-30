output "ssh_key_ids" {
  value       = "IDs for ssh_private keys: ${join(", ", values(boundary_credential_ssh_private_key.main_server_keys)[*].id)}"
  description = "show the id of ssh private key"
}

output "auth_method_id" {
  value       = "BOUNDARY_AUTH_METHOD_ID: ${data.boundary_auth_method.auth_method.id}"
  description = "BOUNDARY_AUTH_METHOD_ID value!"
}

output "target_id" {
  value       = "main servers TARGET_ID for staging, production: ${join(", ", values(boundary_target.main_servers_ssh)[*].id)}"
  description = "show the id of ssh private key"
}

output "scope_id" {
  value       = "the scope id for admins: ${boundary_scope.global.scope_id}"
  description = "show the id of ssh private key"
}

output "boundary_address" {
  value       = "BOUNDARY_ADDR : ${var.boundary_address}"
  description = "the address that boundary is serving at!"
  sensitive   = true
}


output "user_ids" {
  value = "admin user_ids is ${data.boundary_user.global_scope_admin.id} and admin username is ${data.boundary_user.global_scope_admin.name}"
}
