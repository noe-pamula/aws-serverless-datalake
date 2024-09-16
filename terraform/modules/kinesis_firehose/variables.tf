variable "firehose_name" {
  description = "The name of the Kinesis Firehose stream"
  type        = string
}

variable "bucket_arn" {
  description = "The ARN of the S3 bucket where Firehose will deliver data"
  type        = string
}
