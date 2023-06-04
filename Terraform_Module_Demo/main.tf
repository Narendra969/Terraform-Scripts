module "ec2-instance" { # ec2-instance this name can be anything this is like alias name
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.1.0"

    name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "Jenkins_KP"
  monitoring             = true
  vpc_security_group_ids = ["sg-084a022c851ca6c25"]
  subnet_id              = "subnet-0d909198da55239b1"
  ami = "ami-008b85aa3ff5c1b02"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "EC2-Module"
  }
}

module "Jenkins_Instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.1.0"

  instance_type          = "t2.micro"
  ami = "ami-008b85aa3ff5c1b02"
  key_name               = "Jenkins_KP"
  monitoring             = true
  vpc_security_group_ids = ["sg-084a022c851ca6c25"]
  subnet_id              = "subnet-0d909198da55239b1"
  

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "EC2-Module-Demo@2"
  }
}

module "vpc-module" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

   name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
    Name = "my-vpc"
  }
}

/*
Note:
====
# In module block
modeule "vpc-module" {
    source = give the location or path of the module
    vpc-module is the local name to the module, we can give any name
}
# after initializing the terraform and apply, if we want to add another module in the same 
configuration file we can add the module but before plan or apply we need to reintialize the
terraform($ terraform init) or $ terraform get for downloading of the newly added module in the
configuration file
 */