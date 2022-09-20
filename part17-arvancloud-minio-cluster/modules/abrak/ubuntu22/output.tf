output "details-myabrak-id" {
  value = data.arvan_iaas_abrak.get_abrak_id
}

output "adresses" {
  value = arvan_iaas_abrak.myabrak.*.addresses
}