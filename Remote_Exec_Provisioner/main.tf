resource "aws_instance" "demo_instance" {
  instance_type          = "t2.micro"
  ami                    = "ami-008b85aa3ff5c1b02"
  vpc_security_group_ids = [aws_security_group.demosg.id]
  key_name               = "Jenkins_KP"
  tags = {
    Name = "Demo_Instance"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("C:\\Users\\HP\\OneDrive\\Downloads\\interview_qsns\\Jenkins_KP.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd"
    ]
  }

  provisioner "local-exec" {
    command = "echo Hello From Second Local Exec Provisioner"
    when    = create
  }

  provisioner "local-exec" {
    command = "echo Destroy Time Local Exec Provisioner"
    when    = destroy
  }
}

resource "aws_security_group" "demosg" {
  name        = "demo-sg"
  description = "Open ssh and http ports"
  tags = {
    Name = "Dmo_SG"
  }

  ingress {
    description = "SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
# Instead of using Remote Execute Provisioner we can use either user_data or gold images 
(i.e we can create custome AMI by configuring required softwares using packer and use those AMI's 
while creating EC2 Instances using terraform)
# Remote Excecute Provisioner is the last option to configure the instances.
# In windows we need to path location like 
C:\\Users\\HP\\OneDrive\\Downloads\\interview_qsns\\Jenkins_KP.pem
# whereas in Linux we need to path location like 
C/Users/HP/OneDrive/Downloads/interview_qsns/Jenkins_KP.pem
*/
/* 
# on _failure = fail if the provisoner executes fail then terraform stop applying or creating resources.
# on _failure = continue if the provisoner executes fail then terraform will continue applying or creating resources.
# By default on _failure = fail (i.e it takes if we didn't mention)
# when = destroy then the provisioner executes before destroying the resources.
# when = create then the provisioner executes after creation of the resources.
# By default when = create (i.e it takes if we didn't mention)
# we can use multiple provisioners within in a single resource block.
# After creating the resource suppose we update anything in that resource then again apply in that
time local exec provisioners won't execute
# provisioner will execute only at the time of creating the resource or destroying the resouce only
 */
 