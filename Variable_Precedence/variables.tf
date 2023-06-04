variable "aws_region" {
    type = string
    default = "ap-south-1"
    description = "The AWS Region name"
}

variable "availability_zone" {
  type = string
  default = "ap-south-1a"
  description = "The Name of the Availability Zone"
}

variable "ec2count" {
    type = number
    default = 1
    description = "No of EC2 Instances"
}

variable "image_id" {
    type = string
    default = "ami-008b85aa3ff5c1b02"
    description = "AMI Id"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "Type of the EC2 instance"
}