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

module "security_group" {
  source          = "./modules/security_group"
  sg_name         = "sg-http-access"
  region          = var.region
  description     = "Using from devopshobies"
  attach_to_abrak = false
  abrak_uuid      = module.abrak.id
  security_group_rules = [ 
    {
      description = "Open http port"
      direction = "ingress"
      protocol = "tcp"
      port_from = "80"
      port_to = "80"
      ips = ["0.0.0.0/0"]
    },
    {
      description = "Open https port"
      direction = "ingress"
      protocol = "tcp"
      port_from = "443"
      port_to = "443"
      ips = ["0.0.0.0/0"]
    }
  ]
}