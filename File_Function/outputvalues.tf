output "webserver_publicip" {
  value       = aws_instance.webserver.public_ip
  description = "Web Server public IP"
}

output "webserver_privateip" {
  value       = aws_instance.webserver.private_ip
  description = "Web Server private IP"
}

output "webserversg_id" {
  value       = aws_security_group.webserversg.id
  sensitive   = true
  description = "Web Server SG ID"
}

/*
Note:
-----
If we declare "sensitive = true" then the output value or input value won't display in the console.
By default "sensitive = false"
We need to declare "sensitive = true" when we pass database passwords.
*/