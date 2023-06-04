data "aws_ami" "redhat" {
  most_recent = true
  owners      = ["amazon"]

  dynamic "filter" {
    for_each = var.ami_filters
    content {
      name   = filter.key
      values = [filter.value]
    }
  }
}
