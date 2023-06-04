variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "Name of the AWS region"
}

variable "create_ec2" {
    type = bool
    default = true
    description = "Condition either create or not create ec2 instance"
}

variable "availability_zone" {
    type = string
    description = "Name of the Availability Zone"
    default = "ap-south-1a"
}
