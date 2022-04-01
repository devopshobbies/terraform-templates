resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "12.7.4"
  namespace  =  var.namespace

  set {
    name  = "global.imageRegistry"
    value = var.registry
  }

  set {
    name  = "global.storageClass"
    value = var.storageclass
  }

  set {
    name  = "image.repository"
    value = var.repository
  }

  set {
    name  = "image.tag"
    value = var.tag
  }

  set {
    name  = "usePassword"
    value = var.usepass
  }
}
