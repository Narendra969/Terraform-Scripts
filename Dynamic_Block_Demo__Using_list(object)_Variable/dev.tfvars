sg_inbound_rules = [
  {
    cidrblocks  = ["0.0.0.0/0"]
    fromport    = 443
    toport      = 443
    protocol    = "tcp"
    description = "Allow HTTPS Port for Anywhere"
  },
  {
    cidrblocks  = ["172.31.0.0/16", "10.0.0.0/26"]
    fromport    = 8080
    toport      = 8080
    protocol    = "tcp"
    description = "Allow SSH Port for Particular cidr ranges Only"
  }
]


/* 
# suppose we define variable of type map(object) then we should define like below
variable "sg_inbound_rules" {
  description = "Security Group Inbound rules"
  type = map(object({
    fromport    = number
    toport      = number
    description = string
    protocol    = string
    cidrblocks  = list(string)
  }))
  default = {
    "http" = {
      fromport    = 80
      toport      = 80
      description = "Allow HTTP Port for Anywhere"
      protocol    = "tcp"
      cidrblocks  = ["0.0.0.0/0"]
    }
    "ssh" = {
      fromport    = 22
      toport      = 22
      description = "Allow SSH Port for Particular cidr ranges Only"
      protocol    = "tcp"
      cidrblocks  = ["172.31.0.0/16", "10.0.0.0/26"]
    }
  }
} 
*/

/*
# This we need to declare variable values in dev.tfvars file if the variable of type map(object)
 sg_inbound_rules = {
  "http" = {
      fromport    = 80
      toport      = 80
      description = "Allow HTTP Port for Anywhere"
      protocol    = "tcp"
      cidrblocks  = ["0.0.0.0/0"]
  }
  "ssh" = {
      fromport    = 22
      toport      = 22
      description = "Allow SSH Port for Particular cidr ranges Only"
      protocol    = "tcp"
      cidrblocks  = ["172.31.0.0/16", "10.0.0.0/26"]
  }
} 
*/