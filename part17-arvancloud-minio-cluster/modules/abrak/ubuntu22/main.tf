terraform {
  required_providers {
    arvan = {
      source  = "arvancloud/arvan"
      version = "0.6.3" # put the version here
    }
  }
}


variable "abrak-name" {
  type = string
}
variable "abrak-region" {
  type = string
}
variable "os-distro" {
  type    = string
  default = "ubuntu"
}
variable "os-version" {
  type    = string
  default = "22.04"
}
variable "disksize" {
  type    = number
  default = 25
}
variable "abrak-plan" {
  type    = string
  default = "g1-1-1-0"
}
variable "ssh-keyname" {
  type = string
}


resource "arvan_iaas_abrak" "myabrak" {
  region = var.abrak-region
  flavor = var.abrak-plan
  name   = var.abrak-name
  image {
    type = "distributions"
    name = "${var.os-distro}/${var.os-version}"
  }
  disk_size = var.disksize
  ssh_key   = true
  key_name  = var.ssh-keyname
}

