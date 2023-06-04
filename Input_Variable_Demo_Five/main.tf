resource "aws_instance" "demoec2" {
  ami               = var.amiid
  count             = var.ec2count
  instance_type     = var.instancetype
  availability_zone = var.availabilityzone
  tags = {
    Name = "Demo-Server"
  }
}