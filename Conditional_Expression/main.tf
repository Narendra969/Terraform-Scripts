resource "aws_instance" "demoec2" {
   # count = var.create_ec2 ? 1 : 0
    count = var.availability_zone == "ap-south-1a" ? 1 : 0
    ami = " ami-008b85aa3ff5c1b02"
    instance_type = "t2.micro"
    availability_zone = var.availability_zone
    tags = {
      Name = "Demo_Server"
    }
}


/*
Note:
--------------------------------------------------------------------------------------------------
Ex: 1
==================================================================================================
$ terraform plan -var 'create_ec2=false' then no ec2 instance will crete because condition 
we mentioned 0 for false condition.

$ terraform plan -var 'create_ec2=true' then one ec2 instance will crete because condition 
we mentioned 1 for true condition.

Ex: 2
===================================================================================================
$ terraform plan -var 'availability_zone=ap-south-1b' then no ec2 instance will crete because 
condition we mentioned 0 for false condition.

$ terraform plan -var 'availability_zone=ap-south-1a' then one ec2 instance will crete because 
condition we mentioned 1 for true condition.
*/
