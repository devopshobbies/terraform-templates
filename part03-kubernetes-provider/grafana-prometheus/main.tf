terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "1.23.0"
    }
  }
}


