resource "aws_instance" "webserver" {
  ami                    = lookup(var.ami_id_map, "redhat")
  instance_type          = var.instancetype
  vpc_security_group_ids = [aws_security_group.webserversg.id]
  tags = merge(var.common_tags, {
    "Name" = "Web_Server"
  })
  user_data = file("Install-httpd.sh")
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

/*
# for viewing the content of the
locals {
  file_content = file("Install-httpd.sh")
}

output "file" {
  value = local.file_content

}
*/