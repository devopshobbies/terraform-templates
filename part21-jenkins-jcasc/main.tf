resource "virtualbox_vm" "jenkins-node" {
  name      = var.jenkins-node["name"]
  image     = var.jenkins-node["image"]
  cpus      = var.jenkins-node["cpus"]
  memory    = var.jenkins-node["memory"]

  network_adapter {
    type           = var.jenkins-node["type"]
    host_interface = var.jenkins-node["host_interface"]
  }

  provisioner "file" {
    source = "ansible"
    destination = "/home/vagrant"

    connection {
      type = "ssh"
      user = lookup(var.connection, "user", null)
      password = lookup(var.connection, "password", null)
      host = virtualbox_vm.jenkins-node.network_adapter[0].ipv4_address
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install -y ansible",
      "ansible-playbook ansible/jenkins-jcasc.yml"
    ]

    connection {
      type = "ssh"
      user = lookup(var.connection, "user", null)
      password = lookup(var.connection, "password", null)
      host = virtualbox_vm.jenkins-node.network_adapter[0].ipv4_address
    }
  }

}

output "jenkins-node-ip-address" {
  value = virtualbox_vm.jenkins-node.network_adapter[0].ipv4_address
}