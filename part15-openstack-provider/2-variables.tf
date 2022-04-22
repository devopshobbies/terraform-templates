variable "prefix" {
  default = "project1"
}

variable "n_of_masters" {
  default = 1
}

variable "n_of_workers" {
  default = 2
}

variable "cidr" {
  default = "10.0.3.0/24"
}

variable "ssh_key_file" {
default = "~/.ssh/id_rsa"
}

variable "ssh_user_name" {
default = "debian"
}

variable "flavor-master" {
  default = "2C-4GB-5GB"
}
variable "flavor-worker" {
  default = "1C-2GB-5GB"
}