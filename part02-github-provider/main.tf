# Resources

# This resource allows you to create and manage repositories within your GitHub organization or personal account.
resource "github_repository" "new-repo" {
  name        = var.repository_details.name
  description = var.repository_details.description
  auto_init = var.repository_details.auto_init

  visibility = var.repository_details.visibility
}


# This resource allows you to create and manage files within a GitHub repository.
resource "github_repository_file" "new-repo" {
  repository          = github_repository.new-repo.name 
  branch              = var.repository_file_details.branch
  file                = var.repository_file_details.file
  content             = var.repository_file_details.content
  commit_message      = var.repository_file_details.commit_message
  commit_author       = var.repository_file_details.commit_author
  commit_email        = var.repository_file_details.commit_email
  overwrite_on_create = var.repository_file_details.overwrite_on_create
}


# This resource allows you to create and manage branches within your repository.
resource "github_branch" "development" {
  repository = github_repository.new-repo.name
  branch     = var.gitbranch_details
}
