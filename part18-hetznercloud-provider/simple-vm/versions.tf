terraform {
  required_version = ">= 1.2"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.49.1"
    }
  }
}

provider "hcloud" {
  token = var.token
}
