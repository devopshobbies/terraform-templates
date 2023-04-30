# Terraform for your kubernetes

This directory contains Terraform codes to deploy different services and applications on your Kubernetes cluster.

## What I can find here?

You can find examples of:

- ### [MetalLB](./metallb/)

  A load balancer implementation for bare metal Kubernetes clusters. It provides a network load balancer implementation that can handle external traffic to Kubernetes services, in the absence of an external load balancer, such as a cloud provider load balancer or a hardware load balancer.

- ## [Jenkins](./jenkins/)
  Jenkins is an open-source automation server that is used to build, test, and deploy software applications.
- ## [Grafana & Prometheus](./grafana-prometheus)

  This is a great solution to use Grafana and Prometheus together on Kubernetes because they provide very powerful monitoring tools.

  Prometheus can be used to collect data from Kubernetes while Grafana can be used to create custom dashboards that display this data in real time.

- ## [Kubernetes Dashboard](./kubernetes-dashboard/)

  You can understand from the name that the `Kubernetes dashboard` is a GUI for managing Kubernetes cluster by providing an easy way to monitor and manage the resources.

- ## [Nginx Ingress Controller](./nginx-ingress-controller/)
  The NGINX Ingress Controller is a software application that runs on a Kubernetes cluster and provides reverse proxy and load-balancing capabilities for incoming traffic to Kubernetes services.

## How to run the project

If you need guidance, there is little and brief guid about how to start and run the samples.

### Step 1 Clone the repository.

First, you should clone the repository using the below command:

```bash
git clone https https://github.com/devopshobbies/terraform-templates
```

### step2: RUN

```bash
terraform init
terraform fmt
terraform validate
terraform apply
```
