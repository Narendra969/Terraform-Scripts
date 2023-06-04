variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "Name of the AWS region"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/24"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/26", "10.0.0.64/26"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}