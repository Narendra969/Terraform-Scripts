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

data "aws_ami" "redhatlatest" {

  owners      = ["amazon"]
  most_recent = "true"

  filter {
    name   = "name"
    values = ["RHEL-9.2.0_HVM-20230503-x86_64-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

/*
output "redhatlatestamiid" {
  value = "data.aws_ami.redhatlatest.id"
}
*/

resource "aws_instance" "web" {
  ami           = data.aws_ami.redhatlatest.id
  instance_type = "t2.micro"
  count = 2
  tags = {
    Name = "Web_Server-${count.index}"
  }
}
    