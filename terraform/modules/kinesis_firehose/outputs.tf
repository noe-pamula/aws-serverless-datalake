
output "firehose_name" {
  description = "The name of the Kinesis Firehose stream"
  value       = aws_kinesis_firehose_delivery_stream.this.name
}

output "firehose_arn" {
  description = "The ARN of the Kinesis Firehose stream"
  value       = aws_kinesis_firehose_delivery_stream.this.arn
}
