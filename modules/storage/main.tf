resource "aws_s3_bucket" "insecure-bucket" {
  bucket = "insecure-bucket"
  versioning {
    enabled = true
  }

  # Check the AWS provider version to determine if the logging block is needed
  dynamic "logging" {
    for_each = can(tristate(condition, false, null))
    content {
      target_bucket = aws_s3_bucket.logging_bucket.id
      target_prefix = "logs/"
    }
  }
}

# resource "aws_s3_bucket_public_access_block" "insecure-bucket" {
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 20
  encrypted         = true
  tags = {
    Name = "insecure"
  }
}
