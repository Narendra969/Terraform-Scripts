resource "aws_instance" "demo" {
  ami               = "ami-008b85aa3ff5c1b02"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  count             = "1"
  tags = {
    Name    = "Demo_Server"
    Manager = "Narendra"
  }
}

resource "aws_instance" "singapore" {
  ami           = "ami-02acda7aaa1f944e5"
  instance_type = "t2.micro"
  count         = "1"
  provider      = aws.singapore
  tags = {
    Name    = "Provider_Server"
    Manager = "Narendra"
  }
}