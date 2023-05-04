resource "tls_private_key" "sshkey" {
  count     = var.abrak_sshkey_enabled ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "arvan_iaas_sshkey" "sshkey_arvan" {
  count      = var.abrak_sshkey_enabled ? 1 : 0
  name       = var.abrak_sshkey_name
  public_key = tls_private_key.sshkey[0].public_key_openssh
  region     = var.region
}

resource "arvan_iaas_abrak" "abrak" {
  name       = var.abrak_name
  region     = var.region
  flavor     = var.abrak_flavor
  key_name   = var.abrak_sshkey_enabled ? arvan_iaas_sshkey.sshkey_arvan[0].name : null
  disk_size  = var.abrak_disk_size
  ha_enabled = var.abrak_ha_enabled # This is exprimental feature, May not works
  image {
    type = var.abrak_image.type
    name = var.abrak_image.name
  }
}