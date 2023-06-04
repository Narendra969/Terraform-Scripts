variable "amiid" {

}

variable "ec2count" {
 
}

resource "aws_instance" "demoec2" {
  ami               = var.amiid
  count             = var.ec2count
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Demo-Server"
  }
}

/*
1. we can plan or apply then terraform prompt for variable values because we didn't define default 
values and as well as we don't want pass variable values through file while executing terraform 
commands.
2. while destroying also terraform prompt for variable values.
3. If we don't want to terraform prompt for variable values then atleast we should define default 
values then in automation we don't use human intervention otherwise we can pass variable values
through CLI Argument i.e. "-var" option while executing terraform commands.

$ terraform plan
$ terraform apply -auto-approve
*/
