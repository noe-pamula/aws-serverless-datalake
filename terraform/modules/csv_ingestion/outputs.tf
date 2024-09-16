
output "role_arn" {
  description = "The ARN of the IAM role for CSV ingestion"
  value       = aws_iam_role.csv_ingestion_role.arn
}
