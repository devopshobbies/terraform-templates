## this is for load external network from openstack . this use for microstack

# data "openstack_networking_network_v2" "external" {
#   name = "external"
# }


resource "openstack_networking_network_v2" "external" {
  name = "${var.prefix}-network"
  admin_state_up = "true"
  external = "true"
}

resource "openstack_networking_subnet_v2" "kube_cluster_subnet" {
  name =  "${var.prefix}-subnet"
  network_id = openstack_networking_network_v2.external.id
  cidr = var.cidr
  ip_version = 4
  dns_nameservers = ["1.1.1.1","8.8.8.8"]
}

resource "openstack_networking_router_v2" "router" {
  name = "${var.prefix}-router"
  admin_state_up = "true"
  external_network_id = data.openstack_networking_network_v2.external.id
}


# nrif = networking_router_interface
resource "openstack_networking_router_interface_v2" "nrif" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.router.id
}


# master-fip = master networking floatingip
resource "openstack_networking_floatingip_v2" "master-fip" {
  count = var.n_of_masters
  pool = data.openstack_networking_network_v2.external.name
}

# master-fip = worker networking floatingip
resource "openstack_networking_floatingip_v2" "worker-fip" {
  count = var.n_of_workers
  pool = data.openstack_networking_network_v2.external.name
}


resource "openstack_compute_floatingip_associate_v2" "master-fip-assoc" {
  count = var.n_of_masters
  floating_ip = element(openstack_networking_floatingip_v2.master-fip.*.address,count.index+1)
  instance_id = element(openstack_compute_instance_v2.master.*.id,count.index+1)
}

resource "openstack_compute_floatingip_associate_v2" "worker-fip-assoc" {
  count = var.n_of_workers
  floating_ip = element(openstack_networking_floatingip_v2.worker-fip.*.address,count.index+1)
  instance_id = element(openstack_compute_instance_v2.worker.*.id,count.index+1)

}