resource "aws_instance" "demoec2" {
  ami               = var.amiid
  count             = var.ec2count
  instance_type     = "t2.micro"
  availability_zone = var.availabilityzone
  tags = {
    Name = "Demo-Server"
  }
}
