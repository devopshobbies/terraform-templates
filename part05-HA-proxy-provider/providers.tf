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
