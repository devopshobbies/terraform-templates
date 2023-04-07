
output "server_status" {
  value = hcloud_server.vpn.status
}

output "server_ip" {
  value = hcloud_server.vpn.ipv4_address
}
