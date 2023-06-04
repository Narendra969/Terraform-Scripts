resource "aws_security_group" "security_groups" {
  for_each    = var.security_group_rules
  name        = "allow_${each.key}"             # allow _ssh (first time) # allow _http (second time)
  description = "Allow Traffic for ${each.key}" # Allow Traffic for ssh (first time) # Allow Traffic for ssh (second time)

  ingress {
    description = each.value.description # Allow SSH Port (first time) # Allow HTTP Port (second time)
    from_port   = each.value.from_port   # 22 (first time) # 80 (second time)
    to_port     = each.value.to_port     # 22 (first time) # 80 (second time)
    protocol    = each.value.protocol    # "tcp" (first time) # "tcp" (second time) 
    cidr_blocks = each.value.cidr_blocks # [ "0.0.0.0/0" ] (first time) [ "0.0.0.0/0" ] (second time)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all Outbound Traffic"
  }

  tags = {
    Name = "allow_${each.key}"
  }
}

resource "aws_key_pair" "sshkeypair" {
  key_name   = "Demo_Server_Key"
  public_key = file("id_rsa.pub")
}

resource "aws_instance" "demo_server" {
  count                  = 2
  ami                    = "ami-008b85aa3ff5c1b02"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.sshkeypair.key_name
  vpc_security_group_ids = [for securitygroup in aws_security_group.security_groups : securitygroup.id]
  tags = {
    Name = "Demo_Server"
  }
}
