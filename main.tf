resource "aws_s3_bucket" "this" {
  bucket = var.name

  tags = {
    Name = var.name
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.bucket_policy == null ? 0 : 1
  bucket = aws_s3_bucket.this.bucket
  policy = var.bucket_policy
}

resource "aws_s3_bucket_acl" "this" {
  count  = var.bucket_acl == "private" ? 0 : 1
  bucket = aws_s3_bucket.this.bucket
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = var.bucket_acl == "private" ? 1 : 0
  bucket = aws_s3_bucket.this.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "this" {
  count  = var.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.this.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.enable_lifecycle_policy ? 1 : 0
  bucket = aws_s3_bucket.this.bucket

  rule {
    id     = "log"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.kms_master_key_id != null ? "aws:kms" : "AES256"
      kms_master_key_id = var.kms_master_key_id
    }
  }
}

resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_logging && var.logging_target_bucket != null ? 1 : 0
  bucket = aws_s3_bucket.this.bucket

  target_bucket = var.logging_target_bucket
  target_prefix = var.logging_target_prefix
}
