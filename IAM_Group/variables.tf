variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "Name of the AWS region"
}

variable "iamusers" {
  type        = set(string)
  description = "List of IAM Users"
  default     = ["Joe", "Bob", "Smith"]
}