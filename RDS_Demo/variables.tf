variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "Name of the AWS region"
}

variable "mysql_username" {
    type = string
    description = "MySQL RDS Admin Username"
    sensitive = true
}

variable "mysql_password" {
    type = string
    description = "MySQL RDS Admin Password"
    sensitive = true
}