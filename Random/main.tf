resource "aws_s3_bucket" "s3demo" {
  bucket = "nr-${random_string.randoms3name.id}"

}

resource "random_string" "randoms3name" {
  upper   = false            # implicit dependency terraform will automatically manage
  length  = 16               # first terraform will create random string and then create s3 bucket 
  special = false
}
