resource "aws_instance" "demoserver" {
  ami = var.image_id
  instance_type = var.instance_type
  count = var.ec2count
  availability_zone = var.availability_zone
}