#====================#
# Proxmox connection #
#====================#

pm_tls_insecure     = true
pm_api_url          = "https://172.16.1.1:8007/api2/json"
pm_api_token_id     = "terraform-prov@pve!terraform"
pm_api_token_secret = "1a13cf59-efe6-46ee-ae18-31611212cb0a"

#=========================#
# Proxmox virtual machine #
#=========================#

vm_name           = "pxeexample"
clone_name        = "ubuntu-cloud"
vm_target_node    = "pve"
vm_disk_storage   = "local-lvm"
vm_disk_size      = "32G"
vm_network_bridge = "vmbr1"

vm_vcpus      = 2
vm_vcpu_cores = 2
vm_memory     = 4096

vm_cloudinit_network = {
  ip      = "172.16.22.10"
  netmask = "16"
  gateway = "172.16.1.1"
}
vm_cloudinit_sshkeys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1S0n4l9JmuEa2s8V2K8QcrnPZPLXDguzjfRvfSZhXX test@test.com"

