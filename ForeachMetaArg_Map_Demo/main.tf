resource "aws_s3_bucket" "s3-bucket" {
    for_each = {
        dev = "nr-terraform-s3bucket"
        qa  = "nr-terraform-s3bucket"
        prod = "nr-terraform-s3bucket"
    }

    bucket = "${each.key}-${each.value}"

    tags = {
        Name = "${each.key}-${each.value}"
        Environment = "${each.key}"
        ManagedBy = "Terraform"
    }
}