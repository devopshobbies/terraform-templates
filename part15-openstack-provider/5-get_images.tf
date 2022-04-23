resource "openstack_images_image_v2" "debian" {
  name             = "debian"
  #image_source_url = "http://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img"
  local_file_path = "debian-10.11.2-20211129-openstack-amd64.qcow2"
  container_format = "bare"
  disk_format      = "qcow2"
}