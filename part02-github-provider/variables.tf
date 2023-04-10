variable "access_token" {
  default     = "ghp_1MVg--------------------om3wiSKe"
  type        = string
  description = "value of the token"
}

variable "repository_details" {
  type = object({
    name        = string
    description = string
    visibility  = string
    auto_init   = bool
    }
  )
  default = {
    auto_init   = true
    description = "My new repo description"
    name        = "new-repo"
    visibility  = "public"
  }
}
#This resource allows you to create and manage files within a GitHub repository.
variable "repository_file_details" {
  type = object({
    branch              = string
    file                = string
    content             = string
    commit_message      = string
    commit_author       = string
    commit_email        = string
    overwrite_on_create = bool
    }
  )
  default = {
    branch              = "main"
    commit_author       = "Terraform User"
    commit_email        = "terraform@example.com"
    commit_message      = "Managed by Terraform"
    content             = "**/*.tfstate"
    file                = ".gitignore"
    overwrite_on_create = true
  }
}

variable "gitbranch_details" {
  default     = "develop_new_branch"
  type        = string
  description = "value of the branch name"
}
