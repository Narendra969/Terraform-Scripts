locals {
  instancetypemicro  = "t2.micro"
  instancetypemedium = "t2.medium" # name can be anything for the values i.e variable name can be anything
  availabilityzone1a = "ap-south-1a"
  availabilityzone1b = "ap-south-1b"
  ec2ands3tags = {
    Environment = "Dev"
    Name        = "Demo"
    Manager     = "Narendra"
  }
}