resource "aws_instance" "demoserver" {
  ami           = "ami-008b85aa3ff5c1b02"
  instance_type = "t2.micro"
  tags = {
    "Name" = "Demo_Server"
  }

  depends_on = [
    aws_s3_bucket.demos3
  ]

}

resource "aws_s3_bucket" "demos3" {
  bucket = "my-tf-test-bucket-tnb"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.demos3.id
  acl    = "private"
}