
variable "vm_count" {
  type = number
  description = "input number of machine"
}

variable "kvm_server" {
  type = string
}
variable "kvm_privkey" {
  type = string
}

variable "ubuntu_img" {
  type = string
}

variable "storage_pool" {
  type = string
}

variable "base_vm_name" {
  type = string
}

variable "base_hostname" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}