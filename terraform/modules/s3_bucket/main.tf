
resource "aws_s3_bucket" "landing_bucket" {
  bucket = "talosi-datalake-${var.bu}-landing-${var.env}"

  tags = {
    Name        = "talosi-datalake-${var.bu}-landing-${var.env}"
    Environment = var.env
  }
}

resource "aws_s3_bucket" "raw_bucket" {
  bucket = "talosi-datalake-${var.bu}-raw-${var.env}"

  tags = {
    Name        = "talosi-datalake-${var.bu}-raw-${var.env}"
    Environment = var.env
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "landing_bucket_encryption" {
  bucket = aws_s3_bucket.landing_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "raw_bucket_encryption" {
  bucket = aws_s3_bucket.raw_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "landing_bucket_acl" {
  bucket = aws_s3_bucket.landing_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "raw_bucket_acl" {
  bucket = aws_s3_bucket.raw_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "landing_bucket_policy" {
  bucket = aws_s3_bucket.landing_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:*"
        Effect    = "Deny"
        Resource  = "${aws_s3_bucket.landing_bucket.arn}/*"
        Principal = "*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "raw_bucket_policy" {
  bucket = aws_s3_bucket.raw_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:*"
        Effect    = "Deny"
        Resource  = "${aws_s3_bucket.raw_bucket.arn}/*"
        Principal = "*"
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
