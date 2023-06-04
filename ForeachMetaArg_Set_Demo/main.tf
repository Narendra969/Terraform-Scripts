resource "aws_iam_user" "iam-user" {
    for_each = toset(["Bob", "Joe", "Tom"])
    name = each.key
    tags = {
      Name = each.key
    }
}