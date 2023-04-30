<img src="../image/github-provider-banner.jpg">

# GitHub Repository Automation with Terraform

This Terraform code automates the creation of a new GitHub repository, adds a file to it, and creates a new branch within it. The code is written in HashiCorp Configuration Language (HCL) and uses Terraform to manage the resources.

## `github_repository` Resource

This resource creates a new GitHub repository with the name, description, and visibility specified in the `var.repository_details` variable.

- `name`: The name of the new GitHub repository, taken from the `var.repository_details.name` variable.
- `description`: The description of the new GitHub repository, taken from the `var.repository_details.description` variable.
- `auto_init`: Whether to initialize the repository with a README.md file or not, taken from the `var.repository_details.auto_init` variable.
- `visibility`: The visibility of the new GitHub repository, which can be "public", "private", or "internal", taken from the `var.repository_details.visibility` variable.

## `github_repository_file` Resource

This resource creates a new file within the GitHub repository created by the previous resource.

- `repository`: The name of the GitHub repository to add the file to, taken from the `github_repository.new-repo.name` output of the previous resource.
- `branch`: The name of the branch to create or update the file in, taken from the `var.repository_file_details.branch` variable.
- `file`: The path of the file to create or update within the branch, taken from the `var.repository_file_details.file` variable.
- `content`: The content of the file to create or update, taken from the `var.repository_file_details.content` variable.
- `commit_message`: The commit message to use when committing the file changes, taken from the `var.repository_file_details.commit_message` variable.
- `commit_author`: The name of the commit author, taken from the `var.repository_file_details.commit_author` variable.
- `commit_email`: The email of the commit author, taken from the `var.repository_file_details.commit_email` variable.
- `overwrite_on_create`: Whether to overwrite the file if it already exists or not, taken from the `var.repository_file_details.overwrite_on_create` variable.

## `github_branch` Resource

This resource creates a new branch within the GitHub repository created by the first resource.

- `repository`: The name of the GitHub repository to create the branch in, taken from the `github_repository.new-repo.name` output of the first resource.
- `branch`: The name of the new branch, taken from the `var.gitbranch_details` variable.

run these commands:

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
