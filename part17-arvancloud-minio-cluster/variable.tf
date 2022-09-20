variable "ApiKey" {
  type      = string
  default   = "Apikey ************************"
  sensitive = true
}
variable "region" {
  type    = string
  default = "ir-thr-c2"
}
variable "key_path" {
  type    = string
  default = "/root/.ssh/arvan_rsa"
}
variable "server-num" {
  type    = number
  default = 4
}
variable "user_name" {
  type    = string
  default = "ubuntu"
}