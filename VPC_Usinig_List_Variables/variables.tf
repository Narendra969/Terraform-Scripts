variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "Name of the AWS region"
}

variable "vpccidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/24"
}

variable "publicsubnetscidrs" {
  type        = list(string)
  description = "Public Subnets CIDR's"
  default     = ["10.0.0.0/26", "10.0.0.64/26"]
}

variable "privatesubnetscidrs" {
  type        = list(string)
  description = "Private Subnets CIDR's"
  default     = ["10.0.0.128/26", "10.0.0.192/26"]
}

variable "commontags" {
  type        = map(string)
  description = "Common Tags"
  default = {
    "ProjectName" = "Demo",
    "Environment" = "Dev"
  }
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Enable dns support either true or false"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
  description = "Name of the AZ's"
}