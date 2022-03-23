# This terraform code will configure your cisco ASA firewall with some basic policies
What you need for this project:

✅ *Terraform*

✅ *Cisco ASA Firewall*

# Initial ASA Configuration
First we need to configure SSH on our device so terraform can connect to our firewall.
```
ciscoasa# aaa authentication ssh console LOCAL
ciscoasa# username mozart4242 password DevOps priv 15
ciscoasa# aaa authentication enable console LOCAL
ciscoasa# aaa authentication serial console LOCAL
ciscoasa# crypto key generate rsa modulus 1024
ciscoasa# ssh 0.0.0.0 0.0.0.0 inside
ciscoasa# ssh version 2
ciscoasa# configure terminal
ciscoasa(config)# interface management 0/0
ciscoasa(config)# ip address 192.168.45.100 255.255.255.0 192.168.45.232
ciscoasa(config)# nameif INSIDE
ciscoasa(config)# security-level 100
ciscoasa(config)# route INSIDE 0.0.0.0 0.0.0.0 192.168.45.232
```
# Apply your Terraform code
```
terraform init
terraform plan
terraform apply --auto-approve
```
