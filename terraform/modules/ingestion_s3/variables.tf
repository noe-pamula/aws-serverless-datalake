variable "landing_bucket" {
  description = "The name of the landing S3 bucket"
  type        = string
}

variable "raw_bucket" {
  description = "The name of the raw S3 bucket"
  type        = string
}

variable "table_name" {
  description = "The DynamoDB table name containing the metadata"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}
variable "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  type        = string
}
