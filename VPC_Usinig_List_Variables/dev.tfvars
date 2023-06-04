vpccidr             = "172.16.0.0/24"
publicsubnetscidrs  = ["172.16.0.0/26", "172.16.0.64/26"]
privatesubnetscidrs = ["172.16.0.128/26", "172.16.0.192/26"]
availability_zones  = ["ap-south-1b", "ap-south-1c"]
enable_dns_support  = true
commontags = {
  "ProjectName" = "Demo",
  "Environment" = "Develeopment"
}

/*
# if we want to plan or apply using this dev variables file then execute below commands
$ terraform plan -var-file="dev.tfvars"
$ terraform apply -var-file="dev.tfvars" -auto-approve
*/