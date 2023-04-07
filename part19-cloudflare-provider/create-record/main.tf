resource "cloudflare_record" "vpn" {
  zone_id = var.zone_id
  name    = "subdomain"
  value   = var.server_ip
  type    = "A"
  proxied = true
}
