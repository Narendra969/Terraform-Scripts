resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    tags = var.tags
    vpc_security_group_ids = [ aws_security_group.sg.id ]
    key_name = aws_key_pair.sshkeypair.key_name
}

resource "aws_key_pair" "sshkeypair" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "sg" {
    name = var.security_group_name
    description = var.security_group_description

    dynamic "ingress" {
      for_each = var.security_group_inbound_rules
      content {
        from_port = ingress.value.from_port
        to_port = ingress.value.to_port
        protocol = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
        description = ingress.value.description
      }
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.sg_tags
}