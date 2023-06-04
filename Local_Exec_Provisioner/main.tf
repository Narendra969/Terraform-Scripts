resource "aws_instance" "demo_instance" {
  instance_type = "t2.micro"
  ami           = "ami-008b85aa3ff5c1b02"
  key_name      = "Jenkins_KP"
  tags = {
    Name = "Demo_Instance"
  }

  provisioner "local-exec" {
    command    = "echo Hello From First Local Exec Provisioner ${self.public_ip} > pub.txt"
    on_failure = fail
  }

  provisioner "local-exec" {
    command = "echo Hello From Second Local Exec Provisioner"
    when    = create
  }

  provisioner "local-exec" {
    command    = "ech Hello From Second Local Exec Provisioner" # wrong command ech
    when       = create
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo Destroy Time  Local Exec Provisioner "
    when    = destroy
  }
}

resource "aws_s3_bucket" "demos3" {
  depends_on = [aws_instance.demo_instance]
  bucket     = "test-bucket-nr-terraform"
  tags = {
    Name = "Demo_S3"
  }
}

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
 