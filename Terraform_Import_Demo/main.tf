resource "aws_instance" "test" {
    ami = "ami-008b85aa3ff5c1b02"
    instance_type = "t2.micro"
    key_name = "Jenkins_KP"
    availability_zone = "ap-south-1a"

    tags = {
      "Name" = "Test_Server"
    }
}

resource "aws_iam_user" "user" {
    name      = "Narendra"

    tags = {
      "Name" = "Narendra"
    }
}