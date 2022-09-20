# Terraform Provider for ArvanCloud

Set Requirement:
----------------

1. Get an API Key from ArvanCloud Dashboard
2. Set the Variable in variable.tf:

```
#Put Yout Api Key that you get from Arvancloud

variable "ApiKey" {
  type      = string
  default   = "Apikey ************************"
  sensitive = true
}

#Set your Datacenter ID

variable "region" {
  type    = string
  default = "ir-thr-c2"
}

#Set The path of your sshkey that will use for login after create vms

variable "key_path" {
  type    = string
  default = "/root/.ssh/arvan_rsa"
}

#Set your VM Count you want to create

variable "server-num" {
  type    = number
  default = 4
}

#the default of the username of arvan's VMS -> username = OS-Distro-name

variable "user_name" {
  type    = string
  default = "ubuntu"
}
```


How To Use
----------
````
terraform init
terraform plan
#Use `-parallelism=1` for preventing 429 error for create multi VM at the sametime
terraform apply -parallelism=1
````
