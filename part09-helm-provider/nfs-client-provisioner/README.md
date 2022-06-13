# Infrastructure as Code (IaC)

Deploy Kubernetes NFS Client Provisioner on your k8s cluster

Run these commands:
```
$ terraform init
$ terraform validate
$ terraform plan -out planed
$ terraform apply planed
```
To delete:
```
$ terraform destroy
```