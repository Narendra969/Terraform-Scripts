variable "ami_filters" {
  type        = map(string)
  description = "AMI filters"
  default = {
    "name" = "ebs"
    "name" = "hvm"
    "name" = "RHEL-9.2.0_HVM-20230503-x86_64-*"
  }
}

variable "sg_inbound_rules" {
  description = "Security Group Inbound rules"
  type = list(object({
    fromport    = number
    toport      = number
    description = string
    protocol    = string
    cidrblocks  = list(string)
  }))

  default = [{
    cidrblocks  = ["0.0.0.0/0"]
    fromport    = 80
    toport      = 80
    protocol    = "tcp"
    description = "Allow HTTP Port for Anywhere"
    },
    {
      cidrblocks  = ["172.31.0.0/16", "10.0.0.0/26"]
      fromport    = 22
      toport      = 22
      protocol    = "tcp"
      description = "Allow SSH Port for Particular cidr ranges Only"
  }]
}