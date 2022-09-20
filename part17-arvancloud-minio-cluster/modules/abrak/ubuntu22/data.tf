data "arvan_iaas_abrak" "get_abrak_id" {
  depends_on = [
    arvan_iaas_abrak.myabrak
  ]

  region = var.abrak-region
  name   = var.abrak-name
}