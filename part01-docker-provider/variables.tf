variable "nginx_version" {
  default     = "docker_image.nginx.latest"
  type        = string
  description = "value of the nginx container tag"
}
variable "nginx_image_version" {
  default     = "nginx:latest"
  type        = string
  description = "value of nginex version"
}
variable "container_name" {
  default     = "nginx"
  type        = string
  description = "value of the container name"
}
variable "container_host_name" {
  default     = "nginx"
  type        = string
  description = "value of the hostname of the container"
}

variable "internal_container_port" {
  default     = 80
  type        = number
  description = "value of the internal container port"
}
variable "external_container_port" {
  default     = 8000
  type        = number
  description = "value of the external container port"
}
variable "keep_locally" {
  default     = false
  type        = bool
  description = "If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."
}

variable "force_remove" {
  default     = true
  type        = bool
  description = "If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation."
}

variable "container_path" {
  default     = "/usr/share/nginx/html"
  type        = string
  description = "value of the container volumes path"
}
variable "host_path" {
  default     = "/data"
  type        = string
  description = "value of the host_path path"
}
variable "read_only" {
  default     = false
  type        = bool
  description = "If true, this volume will be readonly. Defaults to false"
}
variable "container_restart" {
  default     = "always"
  type        = string
  description = "The restart policy for the container. Must be one of 'no', 'on-failure', 'always', 'unless-stopped'. Defaults to no."
}
variable "container_network" {
  type = object({
    name   = string
    driver = string
  })
  default = {
    driver = "bridge"
    name   = "nginx_network"
  }
}
