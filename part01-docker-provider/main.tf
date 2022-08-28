# Create a docker image resource
# -> docker pull nginx:latest
resource "docker_image" "nginx" {
  name         = var.ngins_image_version
  keep_locally = var.keep_locally
  force_remove = var.force_remove
}

# Create a docker container resource
# -> same as 'docker run --name nginx -p8080:80 -d nginx:latest'
resource "docker_container" "nginx" {
  # The attribute "latest" is deprecated.
  image      = docker_image.nginx.latest
  hostname   = var.container_host_name
  name       = var.container_name
  domainname = var.container_host_name
  restart    = var.container_restart
  ports {
    internal = var.internal_container_port
    external = var.external_container_port
  }

  volumes {
    container_path = var.container_path
    host_path      = var.host_path
    read_only      = var.read_only
  }
}

resource "docker_network" "private_network" {
  name   = var.container_network.name
  driver = var.container_network.driver
}


output "output_p" {
  value = "every thing is ok!"
}