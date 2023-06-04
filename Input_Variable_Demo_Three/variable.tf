variable "amiid" {
  type = string
  description = "The ami id to be use for creating EC2 Instance"
  default = "ami-008b85aa3ff5c1b02"
  validation {
    condition     = length(var.amiid) > 4 && substr(var.amiid, 0, 4) == "ami-"
    error_message = "The amiid value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "ec2count" {
  type = number
  description = "No of EC2 Instances"
  default = "1"
}

variable "availabilityzone" {
    type = string
    description = "The AWS Availability Zone Name"
    default = "ap-south-1a"
    validation {
      condition = contains(["ap-south-1a","ap-south-1b"], var.availabilityzone)
      error_message = "Please select correct Availability Zone Name either ap-south-1a or ap-south-1b"
    }
}

/*
1.we can overwrite default values by executing below terraform command
terraform plan -var "amiid=ami-0607784b46cbe5816" -var "ec2count=2" 
-var "availabilityzone=ap-south-1b" 

2. we can overwrite default values by environment variables also
in Linux or Mac we can define environment variables as below
$ export TF_VAR_Variablename=variablevalue
ex:
$ export TF_VAR_amiid=ami-008b85aa3ff5c1b02
$ export TF_VAR_ec2count=2
$ export TF_VAR_availabilityzone=ap-south-1b
then we can plan or apply like $ terraform plan or $ terraform apply -auto-approve then 
automatically default variable values can be overwritten with ENVIRONMENT Variable values.
*/