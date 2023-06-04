variable "amiid" {
  type = string
  description = "The ami id to be use for creating EC2 Instance"
  default = "ami-008b85aa3ff5c1b02"
}

variable "ec2count" {
  type = number
  description = "No of EC2 Instances"
  default = "1"
}

resource "aws_instance" "demoec2" {
  ami               = var.amiid
  count             = var.ec2count
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Demo-Server"
  }
}

/*
1. we can directly plan or apply because we already define default values to the variables.

$ terraform plan
$ terraform apply -auto-approve

2. we can pass variable values at run time if we didn't define default values to the variables and 
suppose we already define default values again we pass variables values at run time then default 
values can be overwritten with run time values.

$ terraform plan -var "variablename=value" -var "variablename=value"
$ terraform apply -auto-approve -var "variablename=value" -var "variablename=value"

ex: for this example

$ terraform plan -var "amiid=ami-0f5ee92e2d63afc18" -var "ec2count=2"
$ terraform apply -auto-approve -var "amiid=ami-0f5ee92e2d63afc18" -var "ec2count=2" or
$ terraform apply -var "amiid=ami-0f5ee92e2d63afc18" -var "ec2count=2 -auto-approve
*/
