# Terraform State Commands:
=================================================================================================
#1. $ terraform show
---------------------
It will read the state file and show the information in ahuman readable form
-------------------------------------------------------------------------------------------------
# terraform -help or terraform --help or terraform -h: It will show all the terraform commands.
-------------------------------------------------------------------------------------------------
#2. $ terraform state list
--------------------------
It will list out which resources are there in the state file.
It will list out the resources names present in the state file
It will list out like "reourcename.localname"
ex: aws_instance.demo_instance
-------------------------------------------------------------------------------------------------
#2. $ terraform state show <resource_name>
------------------------------------------
Ex: $ terraform state show aws_instance.demo_instance
Then it will show the information of the particular resource i.e It will show the attributes of this resource only.
------------------------------------------------------------------------------------------------
#3. $ terraform refresh command
-------------------------------
Suppose we created the infra using terraform and after that we made some changes to that infra
in this case if execute terraform refresh command it will update the state file according to the whatever we changed manually but it will not update any infra.
# whatever changes we made manually those changes if we want to update to state file then we can execute terraform refresh command.
-------------------------------------------------------------------------------------------------
#4. $ terraform import
-----------------------
By using this command we can import manually created resource into state file 
$ terraform import <resource_name.local_name> <resource id>
Ex:
$ terraform import aws_instance.test i-091130c3b95b40ba6

Ex: Importing aws iam user
$ terraform import <resource_name.local_name> <user_name>
$ terraform import aws_iam_user.user narendra
-------------------------------------------------------------------------------------------------
#5. $ terraform state rm command
--------------------------------
If we want to delete any resouce in the state file then it is possible with terraform state rm command
$ terraform state rm <resource_name.local_name>
Ex:
$ terraform state rm aws_iam_user.user

