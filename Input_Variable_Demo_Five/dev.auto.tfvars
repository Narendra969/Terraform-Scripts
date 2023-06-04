amiid = "ami-0f5ee92e2d63afc18"
ec2count = 1
availabilityzone = "ap-south-1b"
instancetype = "t2.medium"


/*
1.If we already set default values and then again we define variable values in terraform.tfvars then 
default values can be overwritten with terraform.tfvars file values.
2.If we define variable values in exactly "terraform.tfvars" then terraform automatically picks the values 
from this file and overwritten with default values if we set default values already.
3.If we set the variable values in differnt file like dev.tfvars (the file name can be anything but
extension should be .tfvars) in this case terraform won't pick automatically the variable values from
dev.tfvars in this case we need to supply the variable values file at the time of executing terraform
commands like $ terraform plan or apply by using -var-file="dev.tfvars"
ex:
$ terraform plan -var-file="dev.tfvars"
$ terraform apply -var-file="dev.tfvars" -auto-approve
4.If we define variable values in any file i.e the file name can be anything but the extension 
should be .auto.tfvars then terraform will automatically load that variable file we no nned to
pass any variable file by using -var-file="dev.tfvars".
$ terraform plan or 
$ terraform apply -auto-approve 
then the variable values we define in dev.auto.tfvars terraform automatically picks up.
*/