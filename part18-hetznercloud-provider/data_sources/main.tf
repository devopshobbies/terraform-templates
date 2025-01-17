terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.49.1"
    }
  }
}

data "hcloud_locations" "all" {
}

output "locations" {
 value = data.hcloud_locations.all
}

