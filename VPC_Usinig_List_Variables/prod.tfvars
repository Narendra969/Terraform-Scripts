vpccidr             = "10.1.0.0/16"
publicsubnetscidrs  = ["10.1.0.0/19", "10.1.32.0/19", "10.1.64.0/19"]
privatesubnetscidrs = ["10.1.96.0/19", "10.1.128.0/19", "10.1.160.0/19"]
availability_zones  = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
enable_dns_support  = true
commontags = {
  "ProjectName" = "Demo",
  "Environment" = "Production"
}

/*
# if we want to plan or apply using this prod variables file then execute below commands
$ terraform plan -var-file="prod.tfvars"
$ terraform apply -var-file="prod.tfvars" -auto-approve
*/