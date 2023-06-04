amiid = "ami-0f5ee92e2d63afc18"
ec2count = 1
availabilityzone = "ap-south-1b"
instancetype = "t2.medium"


/*
1.If we already set default values an then again we define variable values in terraform.tfvars then 
default values can be overwritten with terraform.tfvars file values.
2.If we define variable values in exactly "terraform.tfvars" then terraform automatically picks the values 
from this file and overwritten with default values if we set already.
3.If we set the variable values in differnt file like ec2.tfvars (the file name can be anything but
extension should be .tfvars) in this terraform won't pick automatically the variable values from
ec2.tfvars in this case we need to supply the variable values file at the time executing terraform
commands like $ terraform plan or apply by using -var-file="ec2.tfvars"
ex:
$ terraform plan -var-file="ec2.tfvars"
$ terraform apply -var-file="ec2.tfvars"
*/