terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu+ssh://root@${var.kvm_server}/system?sshauth=privkey&keyfile=${var.kvm_privkey}"
}


resource "libvirt_pool" "kvm_storage_pool" {

  name = "ubuntu-k8s"
  type = "dir"
  path = var.storage_pool

}

resource "libvirt_volume" "kvm_ubuntu_volume" {

  name   = "ubuntu-2004"
  pool   = libvirt_pool.kvm_storage_pool.name
  source = var.ubuntu_img
  format = "qcow2"
}

resource "libvirt_volume" "vm_volume" {
  count = var.vm_count
  name   = "k8s-${count.index}"
  pool   = libvirt_pool.kvm_storage_pool.name
  base_volume_id = libvirt_volume.kvm_ubuntu_volume.id
  format = "qcow2"
}

resource "libvirt_network" "kvm_network" {
  name = "kubenet"
  mode = "nat"
  addresses = ["10.17.3.0/24"]
  dhcp { 
    enabled = true 
    }
  dns {

    enabled = true
    local_only = true

  }

}


data "template_file" "OS_config" {
    count = var.vm_count
    template = file("${path.module}/cloud_init.cfg")
    vars = {
      hostname = "${var.base_hostname}-${count.index+1}"
    }
}

data "template_file" "network_config"{

    template = file("${path.module}/network_config.cfg")
}


resource "libvirt_cloudinit_disk" "cloud_init" {
  count = var.vm_count
  name           = "cloud_init-${count.index}.iso"
  user_data      = data.template_file.OS_config[count.index].rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.kvm_storage_pool.name
}

resource "libvirt_domain" "k8s" {
    count = var.vm_count
    name = "${var.base_vm_name}-${count.index+1}"
    memory = var.memory
    vcpu = var.cpu
    cloudinit = libvirt_cloudinit_disk.cloud_init[count.index].id
    qemu_agent = true
    network_interface {
      network_id = libvirt_network.kvm_network.id
      hostname = "${var.base_hostname}-${count.index+1}"
      wait_for_lease = true
    }

    disk {
        volume_id = libvirt_volume.vm_volume[count.index].id
    }

}    

output "machin_names" {
    value = [libvirt_domain.k8s.*.name , libvirt_domain.k8s.*.network_interface.0.addresses]
}

terraform {
  required_version = ">= 0.12"
}