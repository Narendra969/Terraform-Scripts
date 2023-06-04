locals {
  amiid = var.ami_id_map[var.ostype]
}

resource "aws_instance" "webserver" {
  ami                    = local.amiid
  instance_type          = var.instancetype
  vpc_security_group_ids = [aws_security_group.webserversg.id]
  tags = merge(var.common_tags, {
    "Name" = "Web_Server"
  })

  user_data = <<-EOF
   #!/bin/bash
   yum update -y
   yum install httpd -y
   systemctl enable httpd
   systemctl start httpd
   echo "Welcome Narendratech.com AWS Infra Created using Terraform" > /var/www/html/index.html 
   systemctl restart httpd
   EOF
}

resource "aws_security_group" "webserversg" {
  name        = "webserversg"
  description = "Allow SSH and HTTP Ports"
  tags = merge(var.common_tags, {
    "Name" = "Web_Server-SG"
  })

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow port 22"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow port 80"
  }

  egress {
    from_port   = 0 # from_port = 0 and to_port = 0 means all ports.
    to_port     = 0
    protocol    = "-1" # protocol = "-1" means all protocols.
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all IPs and Ports for Outbound"
  }
}