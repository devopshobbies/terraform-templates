resource "arvan_iaas_abrak" "abrak" {
  name   = var.abrak_name
	region = var.region
  flavor = var.abrak_flavor
  disk_size = var.abrak_disk_size
	ha_enabled = var.abrak_ha_enabled # This is exprimental feature, May not works
  image {
    type = var.abrak_image.type
    name = var.abrak_image.name
  }
}