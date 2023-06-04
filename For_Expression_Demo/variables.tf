variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "Name of the AWS region"
}

variable "security_group_rules" {
  type = map(object({
    from_port   = number
    to_port     = number
    description = string
    cidr_blocks = list(string)
    protocol    = string
  }))
  default = {
    "ssh" = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH Port"
    },
    "http" = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP Port"
    }
  }
  description = "object of SG Rules"
}

/*
# Object type Variable:
=======================
object means collection of named attributes each have their own type. we can use this object
variables for defining a structural information
*/