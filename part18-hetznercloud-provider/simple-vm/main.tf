resource "hcloud_ssh_key" "default" {
  name       = "hetzner-cloud ssh key"
  public_key = file("~/.ssh/hetzner_ed25519.pub")
}

resource "hcloud_server" "vpn" {
  name        = "vpn"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.default.id]
}

resource "hcloud_network" "hcloud_network" {
  name     = "hetzner-cloud network"
  ip_range = var.ip_range
}

resource "hcloud_network_subnet" "hcloud_subnet" {
  network_id   = hcloud_network.hcloud_network.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.ip_range
}

resource "hcloud_server_network" "vpn_network" {
  server_id = hcloud_server.vpn.id
  subnet_id = hcloud_network_subnet.hcloud_subnet.id
}
