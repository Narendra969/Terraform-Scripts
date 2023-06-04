variable "aws_region" {
    type = string
    description = "AWS Region name"
    default = "ap-south-1"
}

variable "users" {
    type = list(string)
    description = "List of IAM Users"
}

/*
# List will allow duplicate values whereas Set won't allow duplicate values.
# By using toset function we can convert list into set.
# toset function remove duplicate values.
# we can overwrite default variable values or terraform.tfvars or *.auto.tfvars by using - var option
ex:
$ terraform plan -var 'users=["Narendra","Ram","Virat"]'
$ terraform apply -var 'users=["Narendra","Ram","Virat"]' -auto-approve
# use single quote ('') here while passing variable values.
*/