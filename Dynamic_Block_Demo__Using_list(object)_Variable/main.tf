resource "aws_instance" "webserver" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.redhat.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  tags = {
    Name = "Web_Server"
  }
}

resource "aws_security_group" "webserver_sg" {
  name        = "Web_Server_SG"
  description = "Web_Server_Security Group"

  dynamic "ingress" {
    for_each = var.sg_inbound_rules
    content {
      from_port   = ingress.value.fromport
      to_port     = ingress.value.toport
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidrblocks
      description = ingress.value.description
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web_Server_SG"
  }
}

/* 
# By using Dynamic Block we can create repeatable nested blocks.
# A Dynamic is similar to the for expression where for creates repeatable top level resources like
multiple security groups.
# Dynamic creates a nested block within the top level resources like ingress in a security group.
 */