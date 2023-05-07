output "ip_addresses" {
  value = arvan_iaas_abrak.abrak.addresses
}

output "id" {
  value = arvan_iaas_abrak.abrak.id
}

output "ssh_key" {
  value     = var.abrak_sshkey_enabled ? tls_private_key.sshkey[0].private_key_openssh : null
  sensitive = true
}