variable "gitlab_token" {
  type = string
  default = "glpat-y59_VCMmE1cZeQPsjpZH"
}

variable "branch_name" {
  type = string
  default = "test-terraform"
}

variable "project" {
  type        = map(any)
  description = "Your Gitlab project configuration"
  default = {
    "name"             = "terraform-tutorial-project"
    "description"      = "Creating a project using Terraform"
    "visibility_level" = "public"
    "initialize_with_readme" = true
  }
}

variable "gitlab_repository_file_details" {
  type = object({
    file_path_text = string
    file_path_gitignore = string
    branch = string
    content_text = string
    content_git = string
    author_email = string
    author_name = string
    commit_message = string
  })
  default = {
    author_email = "terraform@example.com"
    author_name = "Terraform"
    branch = "main"
    commit_message = "feature: add test file"
    content_text = "lorem ipsum"
    content_git = "**/*.tfstate"
    file_path_text = "test.txt"
    file_path_gitignore = ".gitignore"
  }
}

variable "gitlab_managed_license_details" {
  type = object({
    name = string
    approval_status = string
  })
  default = {
    approval_status = "allowed"
    name = "MIT license"
  }
  
}

variable "ref" {
  type = string
  default = "main"
  description = "The ref which the branch is created from."
}

variable "tag_name" {
  type = string
  default = "my-terraform-tag"
  description = "terraform tag name"
}