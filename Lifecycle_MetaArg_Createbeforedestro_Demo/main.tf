/* first we created ec2 instance 1a az after that we changed the az to 1b by default terraform first 
destroy the instance in 1a az then it will create the instance in 1b az. we can modify this default
behaviour by using lifecycle meta argument */

resource "aws_instance" "demo" {
  ami               = "ami-008b85aa3ff5c1b02"
  instance_type     = "t2.micro"
  #availability_zone = "ap-south-1a"
  availability_zone = "ap-south-1b"
  count             = "1"
  tags = {
    Name    = "Meta"
    Manager = "Narendra"
  }

  lifecycle {
    create_before_destroy = "true"  #Default value is false
    prevent_destroy = "true"  #Default value is false ( we can't destroy the resource if we set 
                               #prevent_destroy equals to true it will protect accidental
                               # termination of like RDS instances)
  }
}
