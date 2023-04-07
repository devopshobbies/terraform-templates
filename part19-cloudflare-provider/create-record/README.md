# Create Record

here we aimed to demonstrate how to create a record in `Cloudflare` with terraform

## Setup

```bash
# add your cloudflare api-token and zone-id to values.tfvars file
printf '%s\n%s' 'token = ""' 'zone_id = ""' > ./values.tfvars

terraform apply -var-file="./values.tfvars"
```

## Destroy

```bash
terraform destroy -var-file="./values.tfvars"
```
