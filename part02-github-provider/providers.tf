# Adding terraform version and terraform provider version on Terraform block
# GitHub Provider Docs: https://registry.terraform.io/providers/integrations/github/latest/docs

terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.23.0"
    }
  }
}


provider "github" {
  # for more authentication ways and other configure options go to https://registry.terraform.io/providers/integrations/github/latest/docs#authentication
  # for more inforamtion for generate token https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

  token = var.access_token   # var.token
}
