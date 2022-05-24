terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.10.0"
    }
    helm = ">= 2.1.0"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nfs-client-provisioner" {

  name = "nfs-client-provisioner"

  repository = "https://kubernetes-sigs.github.io"
  chart      = "nfs-subdir-external-provisioner"
  namespace  = "default"

  set {
    name  = "nfs.server"
    value = var.NFS_SERVER_IP
  }

  set {
    name  = "nfs.path"
    value = var.NFS_PATH
  }
  
}