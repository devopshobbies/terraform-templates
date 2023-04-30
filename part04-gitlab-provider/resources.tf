# Create project
resource "gitlab_project" "project" {
  name                   = var.project.name
  description            = var.project.description
  visibility_level       = var.project.visibility_level
  initialize_with_readme = var.project.initialize_with_readme
}


# Create repository file
resource "gitlab_repository_file" "text" {
  project        = gitlab_project.project.id
  file_path      = var.gitlab_repository_file_details.file_path_text
  branch         = var.gitlab_repository_file_details.branch
  content        = var.gitlab_repository_file_details.content_text
  author_email   = var.gitlab_repository_file_details.author_email
  author_name    = var.gitlab_repository_file_details.author_name
  commit_message = var.gitlab_repository_file_details.commit_message
}

resource "gitlab_repository_file" "git" {
  project        = gitlab_project.project.id
  file_path      = var.gitlab_repository_file_details.file_path_gitignore
  branch         = var.gitlab_repository_file_details.branch
  content        = var.gitlab_repository_file_details.content_git
  author_email   = var.gitlab_repository_file_details.author_email
  author_name    = var.gitlab_repository_file_details.author_name
  commit_message = var.gitlab_repository_file_details.commit_message
}

# Manage license
# This resource requires a GitLab Enterprise instance.
# resource "gitlab_managed_license" "license" {
#   project         = gitlab_project.project.id
#   name            = "MIT license"
#   approval_status = "allowed"
# }

# Create branch
resource "gitlab_branch" "branch" {
  name    = var.branch_name
  ref     = var.ref
  project = gitlab_project.project.id
}

# Create tag
resource "gitlab_project_tag" "tag" {
  name    = var.tag_name
  ref     = var.ref
  project = gitlab_project.project.id
}

# Add a bug label
resource "gitlab_label" "bug" {
  name        = "bug"
  color       = "#000" // Set the color
  description = "This label determines that the issue is reporting a bug"

  project = gitlab_project.project.id
}

# Gitlab pipeline schedule
resource "gitlab_pipeline_schedule" "example" {
  project     = gitlab_project.project.id
  description = "Used to schedule builds"
  ref         = "master"
  cron        = "0 1 * * *"
}


# Schedule gitlab_pipeline_schedule_variable
resource "gitlab_pipeline_schedule_variable" "example" {
  project              = gitlab_project.project.id
  pipeline_schedule_id = gitlab_pipeline_schedule.example.id
  key                  = "EXAMPLE_KEY"
  value                = "example"
}

resource "gitlab_pipeline_trigger" "example" {
  project     = gitlab_project.project.id
  description = "Used to trigger builds"
}
