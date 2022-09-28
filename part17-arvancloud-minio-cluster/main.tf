
module "abrak-sshkey-module" {
  source         = "./modules/ssh-key"
  sshkey-region  = var.region
  ssh-public_key = file("${var.key_path}.pub")
}

module "abrak-module" {
  count        = var.server-num
  abrak-region = var.region
  source       = "./modules/abrak/ubuntu22"
  depends_on = [
    module.abrak-sshkey-module
  ]
  abrak-name  = "minio-${count.index}"
  ssh-keyname = module.abrak-sshkey-module.get-ssh-key.name
}

/* # add extra public ip
module "abrak-public-ip-module" {
  source = "./modules/public-ip"
  depends_on = [
    module.abrak-module
  ]
  region-publicip = var.region
  myabrak_uuid    = module.abrak-module.details-myabrak-id.id
}
 */


module "abrak-subnet-module" {
  network-region = var.region
  source         = "./modules/private-network"
  subnet_name    = "minio"
  ip_range       = "192.168.10.0/24"
}


resource "arvan_iaas_network_attach" "private-network-attach" {
  count = var.server-num
  depends_on = [
    module.abrak-module,
    module.abrak-subnet-module
  ]
  region       = var.region
  abrak_uuid   = module.abrak-module["${count.index}"].details-myabrak-id.id
  network_uuid = module.abrak-subnet-module.subnet-details.network_uuid
  ip           = cidrhost(module.abrak-subnet-module.mynet-ip-range, "${count.index + 2}")

}


resource "local_file" "ansible_inventory" {
  depends_on = [
    arvan_iaas_network_attach.private-network-attach
  ]
  filename = "inventory"
  content = templatefile("inventory.tmpl",
    {
      ansible_ip       = arvan_iaas_network_attach.private-network-attach.*.ip,
      ansible_hostname = module.abrak-module.*.details-myabrak-id.name,
      key_path         = var.key_path
      username         = var.user_name
    }
  )
  provisioner "local-exec" {
    command = "ansible-playbook -i inventory setup-minio.yml "
  }
}