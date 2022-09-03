# Create project
resource "gitlab_project" "project" {
  name        = var.project.name
  description = var.project.description
  visibility_level = var.project.visibility_level
  initialize_with_readme = true
}

# Create repository file
resource "gitlab_repository_file" "file" {
  project        = gitlab_project.project.id
  file_path      = var.gitlab_repository_file_details.file_path
  branch         = var.gitlab_repository_file_details.branch
  content        = var.gitlab_repository_file_details.content
  author_email   = var.gitlab_repository_file_details.author_email
  author_name    = var.gitlab_repository_file_details.author_name
  commit_message = var.gitlab_repository_file_details.commit_message
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
