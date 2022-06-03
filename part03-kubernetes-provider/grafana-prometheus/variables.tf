variable "service_type" {
  description = "Service type"
  default     = "NodePort"
}

variable "service_port" {
  description = "Node port"
  default     = 32323
}

variable "storage_class" {
  default = "managed-nfs-storage"
}

variable "admin_user" {
  description = "admin username for grafana"
  default     = "admin"
}

variable "admin_password" {
  description = "admin password for admin user"
  default     = "admin"
}

variable "grafana_auth" {
  default = "admin:admin"
}

variable "grafana_url" {
  default = "http://10.132.132.102:32323"
}

variable "prometheus_nodeport" {
  default = 32324
}