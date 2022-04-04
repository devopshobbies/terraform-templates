# Adding terraform version and terraform provider version on Terraform block
terraform {
  required_providers {
    docker = {
      source  = "matthisholleville/haproxy"
      version = "0.2.2"
    }
  }
}

provider "haproxy" {
  server_addr = "localhost:5555"
  username    = "admin"
  password    = "adminpwd"
  
  # you may need to allow insecure TLS communications unless you have configured
  # certificates for your server
  insecure = true
}



# Resources

resource "haproxy_frontend" "my-frontend" {
  name = "my-frontend"

  # for more options go to https://registry.terraform.io/providers/matthisholleville/haproxy/latest/docs/resources/frontend#optional
}

resource "haproxy_maps" "my-key" {
  map   = "ratelimit"
  key   = "/metrics"
  value = "50"

  # for more options go to https://registry.terraform.io/providers/matthisholleville/haproxy/latest/docs/resources/maps#optional
}