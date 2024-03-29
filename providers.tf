terraform {
  # backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "deen-terraform-beginner-bootcamp-2023"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  # cloud {
  #   organization = "deen-terraform-beginner-bootcamp-2023"
  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
}

provider "random" {
  # Configuration options
}