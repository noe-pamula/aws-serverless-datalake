output "landing_bucket_name" {
  description = "The name of the landing S3 bucket"
  value       = aws_s3_bucket.landing_bucket.bucket
}

output "landing_bucket_arn" {
  description = "The ARN of the landing S3 bucket"
  value       = aws_s3_bucket.landing_bucket.arn
}

output "raw_bucket_name" {
  description = "The name of the raw S3 bucket"
  value       = aws_s3_bucket.raw_bucket.bucket
}

output "raw_bucket_arn" {
  description = "The ARN of the raw S3 bucket"
  value       = aws_s3_bucket.raw_bucket.arn
}
