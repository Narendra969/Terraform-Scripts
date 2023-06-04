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