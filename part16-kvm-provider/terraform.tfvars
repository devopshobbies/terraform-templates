kvm_server = "192.168.1.3"
kvm_privkey = "/root/.ssh/qemu"
ubuntu_img = "/data/images/ubuntu-20.04-server-cloudimg-amd64-disk-kvm.img"
storage_pool = "/data/terraform-pool-ubuntu"
base_vm_name = "ubuntu-k8s"
base_hostname = "ubuntu-k8s"
cpu = 2 #number of virtual cpu
memory = 2048 #memory in MB