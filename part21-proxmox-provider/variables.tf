#====================#
# Proxmox connection #
#====================#
variable "pm_tls_insecure" {
  description = "Disable TLS"
}

variable "pm_api_url" {
  description = "Proxmox server FQDN or IP"
}

variable "pm_api_token_id" {
  description = "Proxmox API Token ID"
}

variable "pm_api_token_secret" {
  description = "Proxmox API Token Secret"
}

#=========================#
# Proxmox virtual machine #
#=========================#

variable "vm_name" {
  description = "The name of VM"
}

variable "clone_name" {
  description = "Template to clone"
}

variable "vm_target_node" {
  description = "The name of the Proxmox Node"
}

variable "vm_disk_storage" {
  description = "Name of the storage pool"
}

variable "vm_disk_size" {
  description = "The size of the created disk"
}

variable "vm_network_bridge" {
  description = "Bridge to which the network device should be attached"
}

variable "vm_vcpus" {
  description = "The number of vCPU"
}
variable "vm_vcpu_cores" {
  description = "The number of cores per vCPU"
}

variable "vm_memory" {
  description = "The amount of memory to allocate to the VM (example: 2048)"
}

variable "vm_cloudinit_network" {
  description = "Cloud init network configurations"
  default = {
    ip      = "192.16.1.2"
    netmask = "24"
    gateway = "192.16.1.1"
  }
}

variable "vm_cloudinit_sshkeys" {
  description = "Cloud init sshkeys"
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1S0n4l9JmuEa2s8V2K8QcrnPZPLXDguzjfRvfSZhXX test@test.com"
}

