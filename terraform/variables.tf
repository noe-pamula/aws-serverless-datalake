# variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket for the Data Lake"
  type        = string
  default     = "talosi-datalake-serverless"
}

variable "firehose_name" {
  description = "The name of the Kinesis Firehose stream"
  type        = string
  default     = "talosi-firehose-stream"
}

variable "env" {
  description = "The environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
