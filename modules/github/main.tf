provider "github" {
  token = var.github_token
  owner = "cloud-9-aviation"
}

data "github_organization" "cloud-9-aviation" {
  name = "cloud-9-aviation"
}

resource "github_organization_settings" "cloud-9-aviation" {
  description   = "Aircraft rental and flight training"
  name          = "Cloud 9 Aviation LLC"
  billing_email = "ceo@deepspacecartel.com"
  location      = "United States of America"
}

resource "github_repository" "cloud-9-aviation_github_io" {
  # TODO: Try to use 'github_organization_settings' resource.
  name        = "${data.github_organization.cloud-9-aviation.orgname}.github.io"
  description = "https://cloud-9-aviation.github.io/"

  allow_auto_merge       = true
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = true
  vulnerability_alerts   = true
  auto_init              = true
  # homepage_url           = "https://cloud9.avia"
  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path   = "/"
    }
  }
}

resource "github_repository" "terraform" {
  name        = "terraform"
  description = "Infrastructure as Code"
  visibility  = "public"

  allow_auto_merge       = true
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = true
  vulnerability_alerts   = true
  auto_init              = true
  has_downloads          = true
}

resource "github_branch_protection" "terraform" {
  repository_id = github_repository.terraform.node_id
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = [
      "Terraform Cloud/cloud-9-aviation/repo-id-K3moCmuhmPFiwadA"
    ]
  }

  enforce_admins = true
}

resource "github_repository" "office" {
  name        = "office"
  description = "virtual office"
  visibility  = "private"

  allow_auto_merge       = true
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = true
  vulnerability_alerts   = false
  auto_init              = true
  has_downloads          = false
}

resource "github_repository" "devcontainers-templates" {
  name        = "devcontainers-templates"
  description = "Custom Dev Container Templates"
  visibility  = "public"

  allow_auto_merge       = true
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = true
  vulnerability_alerts   = true
  auto_init              = false
  has_downloads          = true
  is_template            = false
  has_wiki               = false
}

resource "github_repository" "devcontainers-features" {
  name        = "devcontainers-features"
  description = "Custom Dev Container Features"
  visibility  = "public"

  allow_auto_merge       = true
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = true
  vulnerability_alerts   = true
  auto_init              = false
  has_downloads          = true
  is_template            = false
  has_wiki               = false
}

resource "github_repository" "pre-commit" {
  name        = "pre-commit"
  description = "Git Hooks"
  visibility  = "public"

  allow_auto_merge       = true
  delete_branch_on_merge = true
  has_issues             = true
  has_projects           = true
  vulnerability_alerts   = true
  auto_init              = true
  has_downloads          = true
  is_template            = false
  has_wiki               = false
}

resource "github_branch_protection" "pre-commit" {
  repository_id = github_repository.pre-commit.node_id
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = [
      "Python CI / publish / publish (pull_request)",
      "Python CI / validation / validation (bandit) (pull_request)",
      "Python CI / validation / validation (black) (pull_request)",
      "Python CI / validation / validation (flake8) (pull_request)",
      "Python CI / validation / validation (pylint) (pull_request)",
      "Python CI / validation / validation (pytest, -m integration) (pull_request)",
      "Python CI / validation / validation (pytest, -m not integration and not gpu) (pull_request)",
      "Semantic PR Check / Validate PR title (pull_request_target)",
    ]
  }

  enforce_admins = true
}
