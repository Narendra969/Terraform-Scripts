terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "terraformprofile"
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "terraformprofile"
  alias   = "singapore"
}