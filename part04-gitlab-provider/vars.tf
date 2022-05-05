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