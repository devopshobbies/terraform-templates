# Terraform for your Gitlab

## Contents

- [Overview](#overview)
- [How to use?](#how-to-use)
- [Roadmap](#roadmap)
- [Contribute](#contribute)

## Overview

This repo contains Terafform codes to interact with GitLab resources, like users, groups, projects and more. You must configure the provider with the proper credentials before you can use it.

## How to use?

Create your own `terraform.tfvars` and copy `terraform.tfvars.example` to it

Check your provider version and initialize Terraform.

```bash
terraform init
```

Now it's time to actually using apply.

```bash
terraform apply
```

Deletes and removes Terraform-managed infrastructure

```bash
terraform destroy
```

## Roadmap

- [x] Create a project
- [x] Manage a file within a repository
- [x] Manage license of a project
- [x] Create a new branch
- [x] Create a tag
- [ ] Manage labels of a project
- [ ] Manage scheduled pipeline
- [ ] Manage pipelines

## Contribute

Contributions are always welcome!
