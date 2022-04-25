resource "openstack_compute_instance_v2" "master" {
  count = var.n_of_masters
  name = "${var.prefix}-master-${count.index+1}"
  image_name =  openstack_images_image_v2.debian.name
  flavor_name = var.flavor-master
  key_pair = openstack_compute_keypair_v2.sshkey.name
  security_groups = ["default"]
  power_state = "active"

  network {
    uuid = openstack_networking_network_v2.external.id
  }
}


resource "openstack_compute_instance_v2" "worker" {
  count = var.n_of_workers
  name = "${var.prefix}-worker-${count.index+1}"
  image_name =  openstack_images_image_v2.debian.name
  flavor_name = var.flavor-worker
  key_pair = openstack_compute_keypair_v2.sshkey.name
  security_groups = ["default"]
  power_state = "active"

  network {
    uuid = openstack_networking_network_v2.external.id
  }

}