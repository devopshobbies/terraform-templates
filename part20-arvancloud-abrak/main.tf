terraform {
  required_providers {
    arvan = {
      source  = "arvancloud/arvan"
      version = "0.6.4" # put the version here
    }
  }
}

module "abrak" {
  source               = "./modules/abrak"
  abrak_name           = var.abrak_name
  region               = var.region
  abrak_sshkey_enabled = var.abrak_sshkey_enabled
  abrak_sshkey_name    = "devopshobies"
  abrak_flavor         = "g1-1-1-0"
  abrak_image = {
    type = "distributions"
    name = "debian/11"
  }
  abrak_disk_size = 25
}