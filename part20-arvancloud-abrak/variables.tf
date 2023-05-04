variable "ApiKey" {
  type      = string
  sensitive = true
}

variable "abrak_name" {
  type    = string
  default = "terraform-abrak-example"
}

variable "region" {
  type    = string
  default = "ir-thr-c2" # Forogh Datacenter
}

variable "abrak_sshkey_enabled" {
  type    = bool
  default = true
}
