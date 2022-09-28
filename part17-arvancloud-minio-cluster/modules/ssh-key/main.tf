terraform {
  required_providers {
    arvan = {
      source  = "arvancloud/arvan"
      version = "0.6.3" # put the version here
    }
  }
}

variable "sshkey-region" {
  type = string
}
variable "ssh-public_key" {
  type = string
}

resource "arvan_iaas_sshkey" "myabrak-sshkey" {
  region     = var.sshkey-region
  name       = "ssh-ubuntu-user"
  public_key = var.ssh-public_key
}