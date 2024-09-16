# variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket for the Data Lake"
  type        = string
  default     = "talosi-datalake-serverless"
}
