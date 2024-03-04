resource "aws_s3_bucket" "example" {
  bucket = "oln-bucket"

  tags = {
    Name        = "OLN bucket"
    Environment = "Dev"
  }
}