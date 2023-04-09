variable "ApiKey" {
  type = string
  default = "<your API-Key>"
  sensitive = true
}

variable "abrak-name" {
  type = string
  default = "terraform-abrak-example"
}

variable "region" {
  type = string
  default = "ir-thr-c2" # Forogh Datacenter
}

