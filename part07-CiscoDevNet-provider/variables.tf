variable "device_address" {
  type        = string
  description = "Management IP Address"
}
variable "username" {
  type        = string
  description = "SSH username"
}
variable "password" {
  type        = string
  description = "SSH password"
}
variable "ntp_address" {
  type        = string
  description = "NTP server IP Address"
}
variable "ntp_key" {
  type        = string
  description = "NTP key, if required"
}
variable "local_subnet" {
  type        = string
  description = "your local subnet need to be like this: 192.168.0.0/26"
}
variable "local_subnet_gw" {
  type        = string
  description = "Gateway ip address to reach your local subnet"
}
