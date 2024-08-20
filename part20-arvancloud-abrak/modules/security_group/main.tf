resource "arvan_iaas_security_group" "security_group" {
  name        = var.sg_name
  region      = var.region
  description = var.description
}

resource "arvan_iaas_security_group_rule" "security_group_rule" {
  security_group_uuid = arvan_iaas_security_group.security_group.id
  region              = var.region
  for_each            = { for id, description in var.security_group_rules : id => description }
  description         = each.value.description
  direction           = each.value.direction
  protocol            = each.value.protocol
  port_from           = each.value.port_from
  port_to             = each.value.port_to
  ips                 = each.value.ips
}

resource "arvan_iaas_abrak_assign_security_group" "security_group_to_abrak" {
  count               = var.attach_to_abrak ? 1 : 0
  region              = var.region
  security_group_uuid = arvan_iaas_security_group.security_group.id
  abrak_uuid          = var.abrak_uuid
}

resource "arvan_iaas_abrak_remove_security_group" "security_group_to_abrak" {
  count               = var.attach_to_abrak ? 0 : 1
  region              = var.region
  security_group_uuid = arvan_iaas_security_group.security_group.id
  abrak_uuid          = var.abrak_uuid
}