resource "openstack_compute_flavor_v2" "flavor-master" {
  name  = var.flavor-master
  ram   = "4096"
  vcpus = "2"
  disk  = "5"
  is_public = "true"
}

resource "openstack_compute_flavor_v2" "flavor-worker" {
  name  = var.flavor-worker
  ram   = "2048"
  vcpus = "1"
  disk  = "5"
  is_public = "true"
}
