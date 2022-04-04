variable "registry" {
  type        = string
  description = "image registry insted of docker hub"
}

variable "storageclass" {
  type        = string
  description = "k8s cluster storageClass"
}

variable "repository" {
  type        = string
  description = "image and epository name" # example = ops/redis
}

variable "tag" {
  type        = string
  description = " image tag or version"
}

variable "usepass" {
  type        = boolean
  description = " The type of disk to create."
}

variable "context" {
  type        = string
  description = " k8s cluster context"
}

variable "namespace" {
  type        = string
  description = " k8s namespace name"
}
