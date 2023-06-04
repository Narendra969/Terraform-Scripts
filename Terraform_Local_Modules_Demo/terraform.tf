terraform {
  required_version = "~> 1.0"
  required_providers { # we can't use variables in terraform block, we can use in provider block
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "terraformprofile"
}