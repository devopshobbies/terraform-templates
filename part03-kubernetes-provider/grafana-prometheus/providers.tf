provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
provider "grafana" {
  alias = "base"
  url   = var.grafana_url
  auth  = var.grafana_auth
}
