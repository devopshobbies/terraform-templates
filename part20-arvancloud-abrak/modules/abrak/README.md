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
| [arvan_iaas_abrak.abrak](https://registry.terraform.io/providers/arvancloud/arvan/latest/docs/resources/iaas_abrak) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_abrak_disk_size"></a> [abrak\_disk\_size](#input\_abrak\_disk\_size) | Abrak disk size in GB | `number` | n/a | yes |
| <a name="input_abrak_flavor"></a> [abrak\_flavor](#input\_abrak\_flavor) | Abrak plan ID, you can get list of plan IDs of each region from sizes api | `string` | n/a | yes |
| <a name="input_abrak_ha_enabled"></a> [abrak\_ha\_enabled](#input\_abrak\_ha\_enabled) | HA feature in abrak. This feature is exprimental, May not works now. | `bool` | `false` | no |
| <a name="input_abrak_image"></a> [abrak\_image](#input\_abrak\_image) | Abrak image type and name | <pre>object({<br>		type = string<br>		name = string<br>	})</pre> | n/a | yes |
| <a name="input_abrak_name"></a> [abrak\_name](#input\_abrak\_name) | Abrak name in Arvancloud web console | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Arvancloud region name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | n/a |
