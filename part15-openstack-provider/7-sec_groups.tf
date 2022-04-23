resource "openstack_compute_secgroup_v2" "sec1" {
  name = "${var.prefix}-network_sec"
  description = "Security group for the instances"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
     cidr = "0.0.0.0/0"
  }
}