## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_arvan"></a> [arvan](#requirement\_arvan) | >=0.6.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_arvan"></a> [arvan](#provider\_arvan) | >=0.6.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [arvan_iaas_abrak_assign_security_group.security_group_to_abrak](https://registry.terraform.io/providers/arvancloud/arvan/latest/docs/resources/iaas_abrak_assign_security_group) | resource |
| [arvan_iaas_abrak_remove_security_group.security_group_to_abrak](https://registry.terraform.io/providers/arvancloud/arvan/latest/docs/resources/iaas_abrak_remove_security_group) | resource |
| [arvan_iaas_security_group.security_group](https://registry.terraform.io/providers/arvancloud/arvan/latest/docs/resources/iaas_security_group) | resource |
| [arvan_iaas_security_group_rule.security_group_rule](https://registry.terraform.io/providers/arvancloud/arvan/latest/docs/resources/iaas_security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_abrak_uuid"></a> [abrak\_uuid](#input\_abrak\_uuid) | Abrak UUID to attach to security group | `string` | `""` | no |
| <a name="input_attach_to_abrak"></a> [attach\_to\_abrak](#input\_attach\_to\_abrak) | Disable this vairable when you want to dettach from abrak | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for security gorup | `string` | `"Created from Terrafrom"` | no |
| <a name="input_region"></a> [region](#input\_region) | Arvancloud region name. | `string` | n/a | yes |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | n/a | <pre>list(object({<br>    description = string<br>    direction   = string<br>    protocol    = string<br>    port_from   = string<br>    port_to     = string<br>    ips         = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "description": "Default description from terraform",<br>    "direction": "ingress",<br>    "ips": [],<br>    "port_from": "0",<br>    "port_to": "1024",<br>    "protocol": "tcp"<br>  }<br>]</pre> | no |
| <a name="input_sg_name"></a> [sg\_name](#input\_sg\_name) | Security group name in Arvancloud web console | `string` | n/a | yes |

## Outputs

No outputs.
