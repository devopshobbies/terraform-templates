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

resource "local_file" "locations_output" {
  content = <<-EOT
    Locations Data:
    Descriptions:
    %{ for desc in data.hcloud_locations.all.descriptions }
    - ${desc}
    %{ endfor }

    Location IDs:
    %{ for id in data.hcloud_locations.all.location_ids }
    - ${id}
    %{ endfor }

    Locations Details:
    %{ for loc in data.hcloud_locations.all.locations }
    - Name: ${loc.name}
      City: ${loc.city}
      Country: ${loc.country}
      Description: ${loc.description}
      Latitude: ${loc.latitude}
      Longitude: ${loc.longitude}
      Network Zone: ${loc.network_zone}
    %{ endfor }

    Names:
    %{ for name in data.hcloud_locations.all.names }
    - ${name}
    %{ endfor }
  EOT

  filename = "${path.module}/locations.txt"
}
