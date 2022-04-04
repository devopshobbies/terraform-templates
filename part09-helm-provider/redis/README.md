# Infrastructure as Code (IaC)

Create a new Redis on your k8s cluster

import your variables in terraform.tfvars file 

See the default vars in https://github.com/bitnami/charts/tree/master/bitnami/redis

run these commands:
```
~$ terraform init
~$ terraform validate
~$ terraform plan -out planed
~$ terraform apply planed
```
for delete:
```
~$ terraform destroy
```
