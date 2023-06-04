locals {
  count = var.create_instance ? var.ec2count : 0
}

resource "aws_instance" "demoserver" {
  ami = var.image_id
  instance_type = var.instance_type
  count = local.count
  availability_zone = var.availability_zone
}

# $ terraform plan -var "create_instance=false" then default value cane be overwritten
# $ terraform apply -var "create_instance=false" -auto-approve
# then condition false then count is 0
# $ terraform apply -var "create_instance=true" -auto-approve
# then count ise ec2count i.e default value is 1 otherwise we can overwite usinf -var "ec2count=10"