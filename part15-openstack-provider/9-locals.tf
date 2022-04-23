locals {

  masters = [
    for i in openstack_compute_floatingip_associate_v2.master-fip-assoc.* : {
      name       = i.instance_id
      ip  = i.floating_ip
    }
  ]

  workers = [
    for i in openstack_compute_floatingip_associate_v2.worker-fip-assoc.* : {
      name       = i.instance_id
      ip  = i.floating_ip
    }
  ]

  inventory = templatefile("${path.module}/templates/hosts.ini", {
    all_nodes    = concat(local.masters, local.workers)
    master_nodes = local.masters
    worker_nodes = local.workers
  })
  depends_on = [openstack_compute_instance_v2.master,openstack_compute_instance_v2.worker]
}

resource "local_file" "inventory" {
  content  = "${local.inventory}"
  filename = "host.ini"
}