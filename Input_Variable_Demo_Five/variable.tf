variable "amiid" {
  type = string
  description = "The ami id to be use for creating EC2 Instance"
  default = "ami-008b85aa3ff5c1b02"
  validation {
    condition     = length(var.amiid) > 4 && substr(var.amiid, 0, 4) == "ami-"
    error_message = "The amiid value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "ec2count" {
  type = number
  description = "No of EC2 Instances"
  default = "5"
}

variable "instancetype" {
    type = string
    default = "t2.micro"
    description = "EC2 Instance type"
}

variable "availabilityzone" {
    type = string
    description = "The AWS Availability Zone Name"
    default = "ap-south-1a"
    validation {
      condition = contains(["ap-south-1a","ap-south-1b"], var.availabilityzone)
      error_message = "Please select correct Availability Zone Name either ap-south-1a or ap-south-1b"
    }
}