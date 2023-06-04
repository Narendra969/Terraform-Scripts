#!/bin/bash
   yum update -y
   yum install httpd -y
   systemctl enable httpd
   echo "Welcome Narendratech.com AWS Infra Created using Terraform" > /var/www/html/index.html 
   systemctl start httpd
   