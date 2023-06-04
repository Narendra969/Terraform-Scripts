resource "aws_instance" "demo" {
  instance_type = "t2.micro"
  ami           = "ami-008b85aa3ff5c1b02"
  key_name      = "Jenkins_KP"
  tags = {
    Name = "Web_Server"
  }
}