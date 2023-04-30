# Terraform for your Gitlab

<img src="https://cdn.hashnode.com/res/hashnode/image/upload/v1614300785186/RIcnyRMzx.png" style="padding: 10px">

## Contents

- [Overview](#overview)
- [How to use?](#how-to-use)
- [Roadmap](#roadmap)
- [Contribute](#contribute)

## Overview

This repository contains terraform codes to interact with GitLab resources, like users, groups, projects and more. Take a tour and check the files so you can have a good understanding of what is happening and how the provider is defined.
It's better to implement the example once after you read and check the code so you can learn more about it.

## How to setup?

Copy the `terraform.tfvars.exmaple` and rename it to `terraform.tfvars`:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Then you can use below commands to test the provider.

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
- [x] Manage labels of a project
- [x] Manage scheduled pipeline
- [x] Manage pipelines

## Contribute

Contributions are always welcome!
