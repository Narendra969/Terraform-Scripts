output "redhatami" {
  value = data.aws_ami.redhat.id
}

output "EC2_Public_IP" {
  value = aws_instance.webserver.public_ip
}