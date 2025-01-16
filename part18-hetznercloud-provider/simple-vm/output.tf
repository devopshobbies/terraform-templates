output "server_ip" {
  description = "The IP address of the created server"
  value       = hcloud_server.node01.ipv4_address
}

output "server_id" {
  description = "The ID of the created server"
  value       = hcloud_server.node01.id
}

output "server_name" {
  description = "The name of the created server"
  value       = hcloud_server.node01.name
}

output "server_status" {
  description = "The status of the created server"
  value       = hcloud_server.node01.status
}
