variable "ami_id" {
    type = string
    description = "AMI ID"
}

variable "instance_type" {
    type = string
    description = "EC2 Instance Type"
}

variable "availability_zone" {
    type = string
    description = "Name of the Availability_Zone"
}

variable "tags" {
    type = map(string)
    description = "Tags for EC2 Instance"
}

variable "security_group_name" {
    type = string
    description = "Security Group Name"
}

variable "security_group_description" {
    type = string
    description = "Security Group Description"
}

variable "security_group_inbound_rules" {
    type = list(object({
      from_port = number
      to_port = number
      protocol = string
      description = string
      cidr_blocks = list(string)
    }))
    description = "Security Group Inbound Rules"
}

variable "sg_tags" {
    type = map(string)
    description = "Tags for Security Group "
}

variable "key_name" {
    type = string
    description = "Key Pair Name"
}

variable "public_key" {
    type = string
    description = "Public_Key File Path"
}