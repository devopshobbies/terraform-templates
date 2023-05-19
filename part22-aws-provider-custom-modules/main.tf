# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#       version = "4.62.0"
#     }
#   }
# }

provider "aws" {
    region = var.web_region
    access_key = var.access_key
    secret_key = var.secret_key 
}


module "custom-server-1" {
    source = ".//module-1"
}