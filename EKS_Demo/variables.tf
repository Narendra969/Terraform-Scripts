variable "aws_region" {
  type        = string
  description = "The AWS Region In Which The Terraform Will Manage The Infrastructure"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "project_name" {
  type        = string
  description = "The Name Of The Project"
  default     = "Demo-EKS"
}

variable "common_tags" {
  type        = map(string)
  description = "The Common Tags For The Project"
  default = {
    "Environment" = "Dev"
    "Owner"       = "Narendra"
  }
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDRs"
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDRs"
  default     = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]
}

variable "eks_node_role_policies" {
  type        = set(string)
  description = "EKS Node Group Policies ARNs"
  default = ["arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  ]
}