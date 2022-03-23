#====================#
# vCenter connection #
#====================#

variable "vsphere_user" {
  description = "vSphere user name"
}

variable "vsphere_password" {
  description = "vSphere password"
}

variable "vsphere_vcenter" {
  description = "vCenter server FQDN or IP"
}

variable "vsphere_unverified_ssl" {
  description = "Is the vCenter using a self signed certificate (true/false)"
}

variable "vsphere_datacenter" {
  description = "vSphere datacenter"
}

variable "vsphere_cluster" {
  description = "vSphere cluster"
  default     = ""
}

#=========================#
# vSphere virtual machine #
#=========================#

variable "vm_datastore" {
  description = "Datastore used for the vSphere virtual machines"
}

variable "vm_network" {
  description = "Network used for the vSphere virtual machines"
}

variable "vm_template" {
  description = "Template used to create the vSphere virtual machines"
}

variable "vm_linked_clone" {
  description = "Use linked clone to create the vSphere virtual machine from the template (true/false). If you would like to use the linked clone feature, your template need to have one and only one snapshot"
  default     = "false"
}

variable "vm_ip" {
  description = "Ip used for the vSpgere virtual machine"
}

variable "vm_netmask" {
  description = "Netmask used for the vSphere virtual machine (example: 24)"
}

variable "vm_gateway" {
  description = "Gateway for the vSphere virtual machine"
}

variable "vm_dns" {
  description = "DNS for the vSphere virtual machine"
}

variable "vm_domain" {
  description = "Domain for the vSphere virtual machine"
}

variable "vm_cpu" {
  description = "Number of vCPU for the vSphere virtual machines"
}

variable "vm_ram" {
  description = "Amount of RAM for the vSphere virtual machines (example: 2048)"
}

variable "vm_name" {
  description = "The name of the vSphere virtual machines and the hostname of the machine"
}