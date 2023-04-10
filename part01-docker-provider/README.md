# About The Template

This Terraform configuration file describes infrastructure as code for deploying a Docker container running the Nginx web server.

## What is happening in template ?

In the `main.tf` file three resources are defined: A docker `image` resource, A docker `container` resource and a Docker `network` resource.

### The Docker image resource:

This resource pulls the latest version of the Nginx image specified in the `var.nginx_image_version` defined in `variables.tf` and allows the option to keep the image locally in the `var.keep_locally` and force to remove the image `var.force_remove`.

```hcl
resource "docker_image" "nginx" {
  name         = var.nginx_image_version
  keep_locally = var.keep_locally
  force_remove = var.force_remove
}
```

### The Docker container resource:

This resource creates a container based on pulled Nginx image by the `docker image resource`. The `docker-container` resource maps the container's port `80` to the host's port `8000`, sets the container hostname, domain name and restart policy, and mounts a host directory as a volume in the container.
You can check the variables in `variables.tf` file to check what is passed.

```hcl
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
```

### The Docker network resource.

And the last resource creates a private network for the container as defined in the `var.container_network`. Finally, a simple note will be printed `Everything is ok`

```h
resource "docker_network" "private_network" {
  name   = var.container_network.name
  driver = var.container_network.driver
}


output "output_p" {
  value = "every thing is ok!"
}
```

## How to run ?

```
$ terraform init
$ terraform validate
$ terraform fmt
$ terraform plan
$ terraform apply
```

for delete:

```
$ terraform destroy
```
