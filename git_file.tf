
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {

token = "ghp_lkLCHnLazhPATWRO3Po9NC8ddfggsdg9IK0Vx1YS56K"
}

resource "github_repository" "example" {
  name        = "myrepoterraform"
  description = "My awesome codebase"

  visibility = "public"

}
