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

  token = "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"   # var.token
}
