output "sg_ids" {
  value = [for securitygroup in aws_security_group.security_groups : securitygroup.id]
  # value = aws_security_group.security_groups[*].id
}

output "demo_server_details" {
  value = [for ec2 in aws_instance.demo_server : ec2.public_ip]
  #value = aws_instance.demo_server[*].public_ip
  # In this we can use either for or splat expression because aws_instance.demo_server[*] gives list
}

output "demo_servers_private_IPs" {
  value = aws_instance.demo_server[*].private_ip
}

/*
Note:
===================================================================================================
# we can use for expression in resource block, local block and also output block.
# for expression can be used in list or map of objects also.
# value = aws_security_group.security_groups[*].id it will through error beacuse of spalt 
expression is not appicable for maps.
value = aws_security_group.security_groups[*] it will give map of strings
# splat expression is only applicable for list.
====================================================================================================
*/
