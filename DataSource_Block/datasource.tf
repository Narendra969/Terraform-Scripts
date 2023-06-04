data "aws_ami" "redhat" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["RHEL-9.2.0_HVM-20230503-x86_64-*"]
  }

}

data "aws_availability_zones" "aws_azs" {
  state = "available"
}