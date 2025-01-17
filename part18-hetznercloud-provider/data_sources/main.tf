data "hcloud_locations" "all" {
}

output "locations" {
 value = data.hcloud_locations.all
}

