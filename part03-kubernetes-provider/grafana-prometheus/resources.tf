#### HELM RESOURCES ####
resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"

  set {
    name  = "service.type"
    value = var.service_type
  }

  set {
    name  = "service.nodePort"
    value = var.service_port
  }

  set {
    name  = "persistence.enabled"
    value = true
  }

  set {
    name  = "persistence.storageClassName"
    value = var.storage_class
  }

  set {
    name  = "adminUser"
    value = var.admin_user
  }
  set {
    name  = "adminPassword"
    value = var.admin_password
  }

}

resource "helm_release" "prometheus" {
  name       = "prometheus-community"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"

  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  set {
    name  = "server.service.nodePort"
    value = var.prometheus_nodeport
  }
  set {
    name  = "server.persistentVolume.storageClass"
    value = var.storage_class
  }

  set {
  name  = "alertmanager.persistentVolume.storageClass"
  value = var.storage_class
  }
}
#### GRAFANA ####
resource "grafana_organization" "my_org" {
  provider = grafana.base
  name     = "my_org"
}

resource "grafana_dashboard" "metrics" {
  provider = grafana.base
  config_json = file("prometheus-dashboard.json")
}

resource "grafana_data_source" "prometheus" {
  provider = grafana.base
  type = "prometheus"
  name = "k8s"
  url  = "http://10.132.132.102:32324"
  access_mode = "proxy"
}