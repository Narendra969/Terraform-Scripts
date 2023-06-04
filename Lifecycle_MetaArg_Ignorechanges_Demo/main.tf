resource "aws_instance" "demo" {
  ami               = "ami-008b85aa3ff5c1b02"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  count             = "1"
  tags = {
    Name    = "Demo_Server"
    Environment = "DEV"
  }
  lifecycle {
    ignore_changes = [ 
        tags,
        # instance_type, like etc we need tell which arguments should ignore
     ]
  }
}


# suppose we have created one resource like ec2 instance through terraform after that we have done 
# some changes to that instance like changing instance type or tags etc manually through console 
# i.e outside of terraform after that suppose we do terraform plan or apply it will detect the
# changes and revert back to the changes according to configurations in this case we don't need to
# terraform revert back those changes then we should use lifecycle meta argument with ignore changes.

/*
resource "aws_instance" "example" {
  # ...

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}
*/
