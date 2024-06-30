# Hashicorp Boundary Provider
 This provider aims at creating and managing Hashicorp boundary resources using best practices.

## How To Use

**First, make sure you have Boundary and Vault (transit key auth) up & running.** 
1. Create a terraform.tfvars file and fill it in with optional values according to `variables.tf`
2. Run the conventional terraform commands to deploy IaC to your boundary instance
```
export BOUNDARY_ADDR="https://your-boundary-instance.com"
export VAULT_TOKEN="vault-transit-token"

terraform init
terraform fmt
terraform validate
terraform plan
terrafrom apply
```

**Replace `vault-transit-token` and `https://your-boundary-instance.com` with your actual values.**

## Bear In Mind
**Using the `Vault Transit recovery key` for auth with Terraform is a best practice, you can create a password auth method manually ON BOUNDARY UI and then `auth_method` related lines in `provider.tf`;  This way you won't necessarily need Vault to use this template.**

- Breaking down resources in `main.tf` into separate tf files is also a plus point for better readability.

- Some features like Credential Injection and Session recording solely come by the paid plan. so uncomment them as you wish in `main.tf`.

- If you're utilizing Vault recovery key ensure `recovery_kms_hcl` directives in `provider.tf` to match your Vault transit engine credentials. 