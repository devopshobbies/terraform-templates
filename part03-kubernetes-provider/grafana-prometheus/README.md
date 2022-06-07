# Terraform for your kuberntes
This repo contains Terafform codes to deploy different services and application on your kubernetes cluster.

## What am i deploying?
We are going to install Grafana using helm with terraform on k8s and then customizing our setup with grafana terraform provider. sounds cool huh ? lets get started

- deploy prometheus and grafana in k8s
- customizing grafana
  - create new organization
  - import prometheus dashboards from a json file



### step1: clone this repo

### step2: RUN
```
$ terraform init
$ terraform fmt
$ terraform validate
$ terraform apply
```

