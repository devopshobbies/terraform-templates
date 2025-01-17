# Simple VM

here we aimed to demonstrate how to create a simple VM in `hetzner cloud` with terraform

## Setup

```bash
# add your hetznercloud api-token to values.tfvars file 
echo 'token = ""' > ./values.tfvars

or use export TF_VAR_token=<TOKEN>

terraform apply -var-file="./values.tfvars"
```

## Destroy

```bash
terraform destroy -var-file="./values.tfvars"
```
