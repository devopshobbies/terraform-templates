jenkins-node = {
  name = "jenkins-node",
  image = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box",
  cpus = 1,
  memory = "2048 mib"
  type = "bridged"
  host_interface = "wlp0s20f3"
}

connection = {
  "user" = "vagrant"
  password = "vagrant"
}