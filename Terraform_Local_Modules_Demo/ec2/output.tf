output "ec2_instance_id" {
  value = aws_instance.ec2.id
}

output "ec2_instance_privateip" {
  value = aws_instance.ec2.private_ip
}

output "ec2_instance_public" {
  value = aws_instance.ec2.public_ip
}

output "sg_id" {
  value = aws_security_group.sg.id
}