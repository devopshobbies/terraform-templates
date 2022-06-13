terraform {
  required_providers {
    ciscoasa = {
      source  = "CiscoDevNet/ciscoasa"
      version = "1.3.0"
    }
  }
}

provider "ciscoasa" {
  api_url       = var.device_address
  username      = var.username
  password      = var.password
  ssl_no_verify = true
}
# Configuring NTP for our beloved firewall
resource "ciscoasa_ntp_server" "ntp_test" {
  ip_address = var.ntp_address
  interface  = "outside"
  key_number = "3"
  key_value  = var.ntp_key
  preferred  = true
}
# Replace this 
resource "ciscoasa_static_route" "ipv4_static_route" {
  interface = "inside"
  network   = var.local_subnet
  gateway   = var.local_subnet_gw
}

resource "ciscoasa_acl" "my_org" {
  name = "aclname"
  rule {
    source              = "192.168.10.5/32"
    destination         = "192.168.15.0/25"
    destination_service = "tcp/443"
  }
  rule {
    source              = "192.168.10.0/24"
    source_service      = "udp"
    destination         = "192.168.15.6/32"
    destination_service = "udp/53"
  }
  rule {
    source              = "192.168.10.0/23"
    destination         = "192.168.12.0/23"
    destination_service = "icmp/0"
  }
}
