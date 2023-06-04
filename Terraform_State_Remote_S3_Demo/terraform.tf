terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-dev-narendra-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-table"
    profile        = "terraformprofile"
  }
}

provider "aws" {
  profile = "terraformprofile"
  region  = "ap-south-1"
}

/*
# In backend configuration we should give credentials for accessing s3 buckend and dynamo db table
# After executing terraform init, if we change anything in the backend configuration then we need
  to execute terraform init -reconfigure 
*/
