variable "jenkins-node" {
    type = object({
      name = string
      image = string
      cpus = number
      memory = string
      type = string
      host_interface = string 
    })
}

variable "connection" {
    type = map(string)
}