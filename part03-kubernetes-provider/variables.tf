############## metallb ##############
variable "metallb_version" {
  default     = "0.10.2"
  type        = string
  description = "MetalLB Version e.g. 0.10.2"
}

variable "controller_toleration" {
  default = []
  type    = list(map(any))
}

variable "controller_node_selector" {
  default = {}
  type    = map(any)
}

############# ingress-nginx ###############
