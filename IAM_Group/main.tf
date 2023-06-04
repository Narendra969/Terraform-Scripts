resource "aws_iam_user" "users" {
  for_each = var.iamusers
  name     = each.value
  tags = {
    Name = "IAM_User_${each.value}"
  }
}

resource "aws_iam_group" "devgroup" {
  name = "development"
}

resource "aws_iam_group_membership" "devgroup_members" {
  name  = "development_group_membership"
  users = [for users in aws_iam_user.users : users.name]
  group = aws_iam_group.devgroup.name
}