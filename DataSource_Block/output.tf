output "redhat_ami_id" {
  value = data.aws_ami.redhat.id
}

output "demoec2_PublicIp" {
  value = aws_instance.demoec2.public_ip
}

output "aws_azs-list" {
  value = data.aws_availability_zones.aws_azs.names
}