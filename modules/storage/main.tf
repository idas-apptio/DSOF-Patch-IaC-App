resource "aws_s3_bucket" "insecure-bucket" {
  bucket = "insecure-bucket"
  versioning {
    enabled = true
    mfa_delete = true
  }
  versioning_configuration {
    mfa_delete = "Enabled"
  }
  logging {
    target_bucket = "your-logging-bucket-name"
    target_prefix = "logs/"  # Optional: specify a prefix for the log objects
  }
}

resource "aws_s3_bucket_logging" "bucket-logging" {
  bucket = aws_s3_bucket.insecure-bucket.id
  target_bucket = "your-logging-bucket-name"
  target_prefix = "logs/"  # Optional: specify a prefix for the log objects
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
