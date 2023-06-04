terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

   backend "s3" {
    bucket         = "terraform-remotestate-practice"
    key            = "dev/terraform_ec2.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-table"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami               = "ami-008b85aa3ff5c1b02"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"

  tags = {
    Name    = "Demo_Server"
    Manager = "Narendra_Babu"
  }
}

/* 
# In this case we pass credentials as environment variable by executing below command
# $ export AWS_PROFILE=terraformprofile

# Note: If we want pass credentials through environment variables then execute below command
# $ export AWS_PROFILE=terraformprofile (we can export aws profile otherwise we can export
# access key and secret key directly) 
===============================================================================================
Note: how to migrate local state file to remote backend: execute below command
===============================================================================================
$ terraform int -migrate-state
==============================================================================================
# don't execute $ terraform init -reconfigure command, if we execute this command the terraform 
create resources agian and maintain the state file in remote backend because we change the 
backend configuration.

# After migrating the state file file to remote backend terraform will use remote backend in
future terraform won't use local state file once configure the remote backend in terraform
block and migrate the local state file to remote backend.
===============================================================================================
*/
