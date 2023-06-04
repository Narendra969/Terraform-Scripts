module "webserver" {
  source            = "./ec2"
  ami_id            = "ami-008b85aa3ff5c1b02"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  tags              = { Name = "Web_Server" }

  security_group_name        = "Web_Server_SG"
  security_group_description = "Allow SSH, HTTP and HTTPS Ports"
  security_group_inbound_rules = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
    }
  ]
  sg_tags = { Name = "Web_Server_SG", Managed = "Terraform" }

  key_name   = "Web_Server_Pub_Key"
  public_key = file("C:\\Users\\HP\\OneDrive\\Downloads\\interview_qsns\\webserverkey.pub")
}

/* 
# we can call this module one more time with differnet values then new instance with differnt values
created 
# But before plan or applying we should either execute $ terraform init (or) $ terraform get
then only intialize the child module with Jenkins Server values
*/

module "Jenkins" {
  source            = "./ec2"
  ami_id            = "ami-0607784b46cbe5816"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1b"
  tags              = { Name = "Jenkins_Server" }

  security_group_name        = "Jenkins_Server_SG"
  security_group_description = "Allow SSH Port and Jenkins_Server Port "
  security_group_inbound_rules = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow Jenkins_Server "
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
    }
  ]
  sg_tags = { Name = "Jenkins_Server_SG", Managed = "Terraform" }

  key_name   = "Jenkins_Server_Pub_Key"
  public_key = file("C:\\Users\\HP\\OneDrive\\Downloads\\interview_qsns\\webserverkey.pub")
}

/*
# Terraform_Local_Modules_Demo directory is the Root Module and ec2 is the child module.
# We can maintain ec2 module in SCM (Git Hub) also, in this scenario in the source we should
tell the git hub path.
 */