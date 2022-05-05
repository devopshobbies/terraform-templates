# Create project
resource "gitlab_project" "project" {
  name        = var.project.name
  description = var.project.description
  visibility_level = var.project.visibility_level
  initialize_with_readme = true
}

# Create repository file
resource "gitlab_repository_file" "fiel" {
  project        = gitlab_project.project.id
  file_path      = "test.txt"
  branch         = "main"
  content        = "lorem ipsum"
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add test file"
}

# Manage license
resource "gitlab_managed_license" "license" {
  project         = gitlab_project.project.id
  name            = "MIT license"
  approval_status = "allowed"
}

# Create branch
resource "gitlab_branch" "branch" {
  name    = var.branch_name
  ref     = "main"
  project = gitlab_project.project.id
}

# Create tag
resource "gitlab_project_tag" "tag" {
  name    = "my-terraform-tag"
  ref     = "main"
  project = gitlab_project.project.id
}
