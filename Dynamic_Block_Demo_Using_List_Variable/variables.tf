variable "ami_filters" {
  type        = map(string)
  description = "AMI filters"
  default = {
    "name" = "ebs"
    "name" = "hvm"
    "name" = "RHEL-9.2.0_HVM-20230503-x86_64-*"
  }
}

variable "sg_inbound_ports" {
  type        = list(number)
  default     = [22, 80, 443]
  description = "List Port Numbers"
}