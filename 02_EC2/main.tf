terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "ap-southeast-1"
  #access_key = "AKIAXLNWIKEP7BOCDGKQ"
  #secret_key = "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"
  profile = "terraformprofile"
}

resource "aws_instance" "demo" {
  ami           = "ami-02acda7aaa1f944e5"
  instance_type = "t2.micro"
  availability_zone = "ap-southeast-1a"
  count = "2"
  tags = {
    Name    = "Demo_Server"
    Manager = "Narendra"
  }
}

resource "aws_s3_bucket" "demobucket" {
  bucket = "nr-terraform-bucket-${count.index}"
  count = "2"
  tags = {
    Name = "Demo-Bucket-${count.index}"
  }
}
