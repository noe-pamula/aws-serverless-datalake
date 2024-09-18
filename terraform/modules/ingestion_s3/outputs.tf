output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.s3_processor_lambda.function_name
}
