
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
  default = "cx11"
}

variable "os_type" {
  type    = string
  default = "ubuntu-22.04"
}

variable "disk_size" {
  type    = string
  default = "20"
}

variable "ip_range" {
  type    = string
  default = "10.0.1.0/24"
}
