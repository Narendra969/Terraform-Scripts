resource "aws_iam_user" "users" {
    for_each = toset(var.users)
    name = each.value
}