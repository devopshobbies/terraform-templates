# Configure Vault with Terraform

## Scenario introduction
Vault administrators must manage multiple Vault environments. The test servers get destroyed at the end of each test cycle and a new set of servers must be provisioned for the next test cycle. To automate the Vault server configuration, you are going to use Terraform to provision the following Vault resources.

|Type|Name|Description|
|----|----|-----------|
|ACL Policy|admins|Sets policies for the admin team|
|ACL Policy|eaas-client|Sets policies for clients to encrypt/decrypt data through transit secrets engine|
|auth method|userpass|Enable and create a user, "student" with admins and fpe-client policies|
|secrets engine|kv-v2|Enable kv-v2 secrets engine at kv-v2|
|secrets engine|transit|Enable transit secrets engine at transit|
|encryption key|payment|Encryption key to encrypt/decrypt data|


## Run Terraform to configure Vault

### Step1: Run Vault server
```
vault server -dev -dev-root-token-id root

export VAULT_TOKEN="root"

export VAULT_ADDR="http://127.0.0.1:8200"
```
### Step2: Run Terraform codes
```
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
