# Simple VM

here we aimed to demonstrate how to create a simple VM in `hetzner cloud` with terraform

## Setup

```bash
echo 'token = ""' > ./values.tfvars
# add your hetznercloud api token to values.tfvars file

terraform apply -var-file="./values.tfvars"
```

## Destroy

```bash
terraform destroy -var-file="./values.tfvars"
```
