# Create Namespace
resource "kubernetes_namespace" "metallb_system" {
  metadata {
    name = "metallb-system"

    labels = {
      app = "metallb"
    }
  }
}
# Create Controller Cluster Role
resource "kubernetes_cluster_role" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:controller"
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list", "watch"]

  }

  rule {
    api_groups = [""]
    resources  = ["services/status"]
    verbs      = ["update"]

  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "patch"]

  }

  rule {
    api_groups     = ["policy"]
    resource_names = ["controller"]
    resources      = ["podsecuritypolicies"]
    verbs          = ["use"]

  }
}

# Create Speaker Cluster Role
resource "kubernetes_cluster_role" "speaker" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:speaker"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "nodes"]
    verbs      = ["get", "list", "watch"]

  }

  rule {
    api_groups = ["discovery.k8s.io"]
    resources  = ["endpointslices"]
    verbs      = ["get", "list", "watch"]

  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "patch"]

  }

  rule {
    api_groups     = ["policy"]
    resource_names = ["speaker"]
    resources      = ["podsecuritypolicies"]
    verbs          = ["use"]

  }
}
# Create Controller Cluster Role Binding Role
resource "kubernetes_cluster_role_binding" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:controller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "metallb-system:controller"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Speaker Cluster Role Binding Role
resource "kubernetes_cluster_role_binding" "speaker" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "metallb-system:speaker"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "metallb-system:speaker"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "speaker"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}
# Create Config Watcher Role Binding
resource "kubernetes_role_binding" "config_watcher" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "config-watcher"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "config-watcher"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.controller.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.speaker.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Pod Lister Role Binding
resource "kubernetes_role_binding" "pod_lister" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "pod-lister"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "pod-lister"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.speaker.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Controller Role Binding
resource "kubernetes_role_binding" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "controller"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.controller.metadata.0.name
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Config Watcher Role
resource "kubernetes_role" "config_watcher" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "config-watcher"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get", "list", "watch"]
  }
}

# Create Pod Lister Role
resource "kubernetes_role" "pod_lister" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "pod-lister"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["list"]
  }
}

resource "kubernetes_role" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create"]
  }

  rule {
    api_groups     = [""]
    resources      = ["secrets"]
    resource_names = ["memberlist"]
    verbs          = ["list"]
  }

  rule {
    api_groups     = ["apps"]
    resources      = ["deployments"]
    resource_names = ["controller"]
    verbs          = ["get"]
  }
}

# Create Controller Deployment
resource "kubernetes_deployment" "controller" {
  metadata {
    labels = {
      app       = "metallb"
      component = "controller"
    }
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  spec {
    revision_history_limit = 3

    selector {
      match_labels = {
        app       = "metallb"
        component = "controller"
      }
    }

    template {
      metadata {
        annotations = {
          "prometheus.io/port"   = "7472"
          "prometheus.io/scrape" = "true"
        }
        labels = {
          app       = "metallb"
          component = "controller"
        }
      }

      spec {

        automount_service_account_token  = true # override Terraform's default false - https://github.com/kubernetes/kubernetes/issues/27973#issuecomment-462185284
        service_account_name             = "controller"
        termination_grace_period_seconds = 0
        node_selector = merge(
          { "kubernetes.io/os" = "linux" },
          var.controller_node_selector
        )
        security_context {
          run_as_non_root = true
          run_as_user     = 65534
        }

        container {
          name  = "controller"
          image = "quay.io/metallb/controller:v${var.metallb_version}"

          args = [
            "--port=7472",
            "--config=config",
          ]

          env {
            name  = "METALLB_ML_SECRET_NAME"
            value = "memberlist"
          }

          env {
            name  = "METALLB_DEPLOYMENT"
            value = "controller"
          }

          port {
            name           = "monitoring"
            container_port = 7472
          }

          security_context {
            allow_privilege_escalation = false
            capabilities {
              drop = ["ALL"]
            }
            read_only_root_filesystem = true
          }
        }

        dynamic "toleration" {
          for_each = var.controller_toleration
          content {
            key                = toleration.value["key"]
            effect             = toleration.value["effect"]
            operator           = lookup(toleration.value, "operator", null)
            value              = lookup(toleration.value, "value", null)
            toleration_seconds = lookup(toleration.value, "toleration_seconds", null)
          }
        }
      }
    }
  }
}

# Create Controller Service Account
resource "kubernetes_service_account" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "controller"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Speaker Service Account
resource "kubernetes_service_account" "speaker" {
  metadata {
    labels = {
      app = "metallb"
    }
    name      = "speaker"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }
}

# Create Speaker DaemonSet
resource "kubernetes_daemonset" "speaker" {
  metadata {
    labels = {
      app       = "metallb"
      component = "speaker"
    }
    name      = "speaker"
    namespace = kubernetes_namespace.metallb_system.metadata.0.name
  }

  spec {
    selector {
      match_labels = {
        app       = "metallb"
        component = "speaker"
      }
    }

    template {
      metadata {
        annotations = {
          "prometheus.io/port"   = "7472"
          "prometheus.io/scrape" = "true"
        }
        labels = {
          app       = "metallb"
          component = "speaker"
        }
      }

      spec {

        automount_service_account_token  = true # override Terraform's default false - https://github.com/kubernetes/kubernetes/issues/27973#issuecomment-462185284
        service_account_name             = "speaker"
        termination_grace_period_seconds = 2
        host_network                     = true
        node_selector = {
          "kubernetes.io/os" = "linux"
        }

        toleration {
          key      = "node-role.kubernetes.io/master"
          effect   = "NoSchedule"
          operator = "Exists"
        }

        container {
          name  = "speaker"
          image = "quay.io/metallb/speaker:v${var.metallb_version}"

          args = [
            "--port=7472",
            "--config=config",
          ]

          env {
            name = "METALLB_NODE_NAME"
            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }

          env {
            name = "METALLB_HOST"
            value_from {
              field_ref {
                field_path = "status.hostIP"
              }
            }
          }

          env {
            name = "METALLB_ML_BIND_ADDR"
            value_from {
              field_ref {
                field_path = "status.podIP"
              }
            }
          }

          env {
            name  = "METALLB_ML_LABELS"
            value = "app=metallb,component=speaker"
          }

          env {
            name = "METALLB_ML_SECRET_KEY"
            value_from {
              secret_key_ref {
                name = "memberlist"
                key  = "secretkey"
              }
            }
          }

          port {
            name           = "monitoring"
            container_port = 7472
            host_port      = 7472
          }

          port {
            name           = "memberlist-tcp"
            container_port = 7946
            # host_port      = 7946
          }

          port {
            name           = "memberlist-udp"
            protocol       = "UDP"
            container_port = 7946
            # host_port      = 7946
          }

          security_context {
            allow_privilege_escalation = false
            capabilities {
              add  = ["NET_RAW"]
              drop = ["ALL"]
            }
            read_only_root_filesystem = true
          }

        }
      }
    }
  }
}

# Create Controller Pod Security Policy
resource "kubernetes_pod_security_policy" "controller" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "controller"
    #namespace = "metallb-system"
  }
  spec {
    allow_privilege_escalation = false
    allowed_capabilities       = []
    #allowed_host_paths {}
    default_add_capabilities           = []
    default_allow_privilege_escalation = false

    fs_group {
      range {
        max = 65535
        min = 1
      }
      rule = "MustRunAs"
    }

    host_ipc                   = false
    host_network               = false
    host_pid                   = false
    privileged                 = false
    read_only_root_filesystem  = true
    required_drop_capabilities = ["ALL"]

    run_as_user {
      range {
        max = 65535
        min = 1
      }
      rule = "MustRunAs"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      range {
        max = 65535
        min = 1
      }
      rule = "MustRunAs"
    }

    volumes = [
      "configMap",
      "secret",
      "emptyDir",
    ]
  }
}

# Create Speaker Pod Security Policy
resource "kubernetes_pod_security_policy" "speaker" {
  metadata {
    labels = {
      app = "metallb"
    }
    name = "speaker"
    #namespace = "metallb-system"
  }
  spec {
    allow_privilege_escalation = false
    allowed_capabilities       = ["NET_RAW"]
    #allowed_host_paths {}
    default_add_capabilities           = []
    default_allow_privilege_escalation = false

    fs_group {
      rule = "RunAsAny"
    }

    host_ipc     = false
    host_network = true
    host_pid     = false

    host_ports {
      max = 7472
      min = 7472
    }

    host_ports {
      max = 7946
      min = 7946
    }

    privileged                 = true
    read_only_root_filesystem  = true
    required_drop_capabilities = ["ALL"]

    run_as_user {
      rule = "RunAsAny"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "RunAsAny"
    }

    volumes = [
      "configMap",
      "secret",
      "emptyDir",
    ]
  }
}
resource "kubectl_manifest" "metallb_configmap" {
  yaml_body = file("./configmap.yml")
}