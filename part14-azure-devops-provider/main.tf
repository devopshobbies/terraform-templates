terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.53.0"
    }
  }
}

resource "azurerm_resource_group" "terraform_azure_provider" {
  location = "East US"
  name = "terraform_azure_provider"
}

module "network" {
    source              = "Azure/network/azurerm"
    resource_group_name = azurerm_resource_group.terraform_azure_provider.name
    subnet_prefixes     = ["10.0.1.0/24"]
    subnet_names        = ["subnet1"]
    // Use for_each instead of count to create multiple resource instances.
    use_for_each = true
    depends_on = [azurerm_resource_group.terraform_azure_provider]
}

module "linuxservers" {
    source = "Azure/compute/azurerm"
    resource_group_name = azurerm_resource_group.terraform_azure_provider.name
    vm_os_simple = "UbuntuServer"
    public_ip_dns = ["linsimplevmips"] // change to a unique name per datacenter region
    vnet_subnet_id = module.network.vnet_subnets[0]

    
    depends_on = [azurerm_resource_group.terraform_azure_provider]
}



output "linux_vm_public_name" {
    value = module.linuxservers.public_ip_dns_name
}

