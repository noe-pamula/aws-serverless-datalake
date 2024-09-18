output "landing_bucket_id" {
  description = "The ID of the S3 landing bucket"
  value       = module.storage.landing_bucket_name
}

output "raw_bucket_id" {
  description = "The ID of the S3 raw bucket"
  value       = module.storage.raw_bucket_name
}