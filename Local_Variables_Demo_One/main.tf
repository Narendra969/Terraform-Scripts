locals {
  instancetypemicro  = "t2.micro"
  instancetypemedium = "t2.medium" # name can be anything for the values i.e variable name can be anything
  availabilityzone1a = "ap-south-1a"
  availabilityzone1b = "ap-south-1b"
  ec2ands3tags = {
    Environment = "Dev"
    Name        = "Demo"
    Manager = "Narendra"
  }
}

resource "aws_instance" "demoec2-micro" {
  ami               = "ami-008b85aa3ff5c1b02"
  instance_type     = local.instancetypemicro
  availability_zone = local.availabilityzone1a
  tags              = local.ec2ands3tags
}

resource "aws_s3_bucket" "demos3bucket" {
  bucket = "nr-terraform-s3-demo"
  tags   = local.ec2ands3tags
}

resource "aws_instance" "demoec2-medium" {
  ami               = "ami-008b85aa3ff5c1b02"
  instance_type     = local.instancetypemedium
  availability_zone = local.availabilityzone1b
  tags              = local.ec2ands3tags
}