terraform {
  required_providers {
    arvan = {
      source  = "arvancloud/arvan"
      version = "0.6.3" # put the version here
    }
  }
}
variable "network-region" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "ip_range" {
  type    = string
  default = "192.168.0.0/24"
}
resource "arvan_iaas_subnet" "mysubnet" {
  region         = var.network-region
  name           = "${var.subnet_name}-subnet"
  subnet_ip      = var.ip_range
  enable_gateway = false
  #gateway = cidrhost(var.ip_range,1)
  dns_servers = [
    "8.8.8.8",
    "4.2.2.4"
  ]
  enable_dhcp = false
}