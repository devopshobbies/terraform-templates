resource "openstack_compute_keypair_v2" "sshkey" {
  name = "${var.prefix}-keypair"
  public_key = file("${var.ssh_key_file}.pub")
} 