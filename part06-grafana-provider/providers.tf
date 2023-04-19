# Adding terraform version and terraform provider version on Terraform block
# Grafana Provider Docs: https://registry.terraform.io/providers/grafana/grafana/latest/docs

terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "1.21.1"
    }
  }
}


provider "grafana" {
  url  = "https://grafana.example.com/"  # The root URL of a Grafana server.
  org_id = "1"  # The organization id to operate on within grafana.
  auth = "username:password"  # This can be a Grafana API key or basic auth username:password. Alternatively could be set via the GRAFANA_AUTH environment variable.
  insecure_skip_verify = true  # Skip TLS certificate verification.

  # For more authentication ways and for optional options go to: https://registry.terraform.io/providers/grafana/grafana/latest/docs#authentication
}
