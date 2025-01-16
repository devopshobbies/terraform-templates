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

resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [all]
    ${hcloud_server.node01.name} ansible_host=${hcloud_server.node01.ipv4_address} ansible_user=root ansible_ssh_private_key_file=~/.ssh/hetzner_ed25519

    [all:vars]
    ansible_become=true
    ansible_become_method=sudo
    ansible_python_interpreter=/usr/bin/python3
  EOT

  filename = "./ansible_inventory.ini"
}
