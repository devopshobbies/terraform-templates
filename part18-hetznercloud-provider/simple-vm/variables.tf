
variable "token" {
  type      = string
  sensitive = true
}

variable "location" {
  type    = string
  default = "nbg1"
}

variable "server_type" {
  type    = string
  default = "cx32"
}

variable "os_type" {
  type    = string
  default = "ubuntu-20.04"
}
variable "ip_range" {
  type    = string
  default = "10.0.1.0/24"
}
