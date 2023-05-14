terraform {
  required_version = ">= 1.1.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.14"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure     = var.pm_tls_insecure
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}

resource "proxmox_vm_qemu" "pxe-example" {
  name  = var.vm_name
  boot  = "order=scsi0;net0"
  cores = var.vm_vcpu_cores
  vcpus = var.vm_vcpus
  cpu   = "host"
  memory      = var.vm_memory
  qemu_os     = "other"
  scsihw      = "virtio-scsi-pci"
  target_node = var.vm_target_node

  disk {
    discard     = "on"
    iothread    = 1
    size        = var.vm_disk_size
    ssd         = 1
    storage     = var.vm_disk_storage
    type        = "scsi"
  }

  network {
    bridge   = var.vm_network_bridge
    firewall = false
    model    = "e1000"
  }

  clone   = var.clone_name
  os_type = "cloud-init"
  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0 = "ip=${var.vm_cloudinit_network.ip}/${var.vm_cloudinit_network.netmask},gw=${var.vm_cloudinit_network.gateway}"

  ciuser  = "ubuntu"
  sshkeys = <<EOF
  ${var.vm_cloudinit_sshkeys}
  EOF
}
