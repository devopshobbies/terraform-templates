############# Jenkins ###############
variable "request_storage" {
  description = "storage for your jenkins installation"
  default     = "5Gi"
}

variable "accessmode" {
  description = "access mode for jenkins persistent volume claim"
  default     = "ReadWriteOnce"
}

variable "name" {
  description = "name of your jenkins application, will be used as prefix for all manifests"
  default     = "jenkins"
}

variable "namespace" {
  description = "namespace where all the jenkins resources will be created"
  default     = "jenkins"
}

variable "storageclass" {
  description = "storageclass to use for creating persistent volume claim, defaults to gp2 of AWS"
  default     = "managed-nfs-storage"
}

variable "jenkins_image" {
  description = "docker image with the tag"
  default     = "jenkins/jenkins:latest"
}

variable "replicas" {
  description = "no. of replicas you want"
  default     = "1"
}