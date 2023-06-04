locals {
  azs = data.aws_availability_zones.aws_azs.names
}

resource "aws_instance" "demoec2" {
  ami           = data.aws_ami.redhat.id
  instance_type = "t2.micro"
  availability_zone = local.azs[1]
  tags = {
    Name = "Dmo-EC2"
  }
}