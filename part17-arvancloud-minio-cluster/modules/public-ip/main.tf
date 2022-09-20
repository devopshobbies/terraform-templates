terraform {
  required_providers {
    arvan = {
      source  = "arvancloud/arvan"
      version = "0.6.3" # put the version here
    }
  }
}

variable "region-publicip" {
  type = string
}
variable "myabrak_uuid" {
  type = string
}

resource "arvan_iaas_abrak_action" "myabrak-publicip" {
  action     = "add-public-ip"
  region     = var.region-publicip
  abrak_uuid = var.myabrak_uuid
}