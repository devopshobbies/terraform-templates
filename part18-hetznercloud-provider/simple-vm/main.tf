# for generate ssh key:  ssh-keygen -t ed25519 -f ~/.ssh/hetzner_ed25519
resource "hcloud_ssh_key" "default" {
  name       = "hetzner-cloud ssh key"
  public_key = file("~/.ssh/hetzner_ed25519.pub")
}

resource "hcloud_server" "node01" {
  name        = "node01"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.default.id]
  labels = {
    "Server" : "node01"
  }
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
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

resource "hcloud_server_network" "node01_network" {
  server_id = hcloud_server.node01.id
  subnet_id = hcloud_network_subnet.hcloud_subnet.id
}
