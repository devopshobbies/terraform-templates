output "abrak_id" {
  value = module.abrak.id
}

output "abrak_ip_addresses" {
  value = module.abrak.ip_addresses
}

output "abrak_sshkey" {
  value     = var.abrak_sshkey_enabled ? module.abrak.ssh_key : null
  sensitive = true
}