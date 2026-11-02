resource "aws_s3_bucket" "demo" {
  bucket = "demo-test-bucket"
  acl    = "private-read"
}
