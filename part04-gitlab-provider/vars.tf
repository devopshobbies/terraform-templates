variable "gitlab_token" {
  type = string
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
  }
}

variable "gitlab_repository_file_details" {
  type = object({
    file_path = string
    branch = string
    content = string
    author_email = string
    author_name = string
    commit_message = string
  })
  default = {
    author_email = "terraform@example.com"
    author_name = "Terraform"
    branch = "main"
    commit_message = "feature: add test file"
    content = "lorem ipsum"
    file_path = "test.txt"
  }
}