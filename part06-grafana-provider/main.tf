# Resources
# Sample senario: new user -> new team -> new folder -> new dashboard -> set folder permissions


# Create new user.
# This one does not currently work with API Tokens. You must use basic auth.
resource "grafana_user" "new_user" {
  email    = "devops.user@example.com"
  password = "test"
}


# Create new team.
resource "grafana_team" "new_team" {
  name = "DevOps Team"
  members = [
    grafana_user.new_user.email
  ]
}


# Create new folder.
resource "grafana_folder" "new_folder_with_uid" {
  uid   = "test-folder-uid"
  title = "Terraform Test Folder With UID"
}


# Create new dashboard in a specific folder.
resource "grafana_dashboard" "new_dashboard" {
  folder      = grafana_folder.new_folder_with_uid.id
  config_json = <<EOD
{
  "title": "Dashboard in folder",
  "uid": "dashboard-in-folder"
}
EOD
}


# Set folder permissions to assign who can view and edit the folder.
resource "grafana_folder_permission" "folder_permission" {
  folder_uid = grafana_folder.new_folder_with_uid.uid
  permissions {
    role       = "Editor"
    permission = "Edit"
  }
  permissions {
    team_id    = grafana_team.new_team.id
    permission = "View"
  }
  permissions {
    user_id    = grafana_user.new_user.id
    permission = "Admin"
  }
}