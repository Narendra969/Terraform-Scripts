terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-dev-narendra-state-bucket"
    key            = "Importexisting/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-table"
    profile        = "terraformprofile"
  }
}

provider "aws" {
  profile = "terraformprofile"
  region  = "ap-south-1"
}