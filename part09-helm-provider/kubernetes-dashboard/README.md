# Infrastructure as Code (IaC)

Deploy kubernetes-dashboard on your k8s cluster

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