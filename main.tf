terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "cloud-9-aviation"
    workspaces {
      name = "terraform"
    }
  }
}

module "github" {
  source           = "./modules/github"
  github_token     = var.github_token
}
