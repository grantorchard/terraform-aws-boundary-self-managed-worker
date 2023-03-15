terraform {
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 4"
    # }
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.1.3"
    }
  }
}

# provider "hcp" {}

# provider "aws" {}

provider "boundary" {
  addr                            = var.boundary_addr
  auth_method_id                  = "ampw_7HBv1E399l"
  password_auth_method_login_name = var.boundary_username
  password_auth_method_password   = var.boundary_password
}