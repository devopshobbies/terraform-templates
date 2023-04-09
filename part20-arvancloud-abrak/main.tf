terraform {
  cloud {
    organization = "MBC"

    workspaces {
      name = "getting-started"
    }
  }
  required_providers {
    arvan = {
      source  = "arvancloud/arvan"
      version = "0.6.4" # put the version here
    }
  }
}

resource "arvan_iaas_abrak" "abrak-1" {
  region = var.region
  flavor = "g1-1-1-0"
  name   = var.abrak-name
  image {
    type = "distributions"
    name = "debian/11"
  }
  disk_size = 25
}

data "arvan_iaas_abrak" "get_abrak_id" {
  depends_on = [
    arvan_iaas_abrak.abrak-1
  ]

  region = var.region
  name   = var.abrak-name
}