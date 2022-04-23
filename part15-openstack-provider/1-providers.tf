terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
    template = {
      source = "hashicorp/template"
      version = "2.2.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  cloud  = "openstack" # cloud defined in cloud.yml file
  #insecure = true
}