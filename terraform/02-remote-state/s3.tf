resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-b35"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}