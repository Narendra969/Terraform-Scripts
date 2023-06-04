variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "Name of the AWS region"
}

variable "ostype" {
  type        = string
  default     = "redhat"
  description = "Name of the OS"
}

variable "ami_id_map" {
  type        = map(string)
  description = "AMI ID's Map based on OS Type"
  default = {
    "redhat" = "ami-008b85aa3ff5c1b02"
    "ubuntu" = "ami-0f5ee92e2d63afc18"
    "amazon" = "ami-0607784b46cbe5816"
  }
}

variable "instancetype" {
  type        = string
  default     = "t2.micro"
  description = "The type of the EC2 Instance"
}

variable "common_tags" {
  type        = map(string)
  description = "common tags for the sesources"
  default = {
    "Project" = "Demo_Project"
  }
}