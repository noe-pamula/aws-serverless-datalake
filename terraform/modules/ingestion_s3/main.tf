resource "aws_lambda_function" "s3_processor_lambda" {
  filename         = "${path.module}/ingestion_function.zip"
  function_name    = "s3_processor_function"
  handler          = "handler.lambda_handler"
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_exec.arn
  source_code_hash = filebase64sha256("${path.module}/ingestion_function.zip")

  environment {
    variables = {
      LANDING_BUCKET = var.landing_bucket
      RAW_BUCKET     = var.raw_bucket
      DYNAMODB_TABLE = var.table_name
    }
  }

}

resource "aws_iam_role" "lambda_exec" {
  name = "s3_processor_lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::${var.landing_bucket}/*",
          "arn:aws:s3:::${var.raw_bucket}/*"
        ]
      },
      {
        Action   = [
          "dynamodb:GetItem"
        ]
        Effect   = "Allow"
        Resource = var.dynamodb_table_arn
      }
    ]
  })
}

resource "aws_lambda_permission" "allow_s3_invocation" {
  statement_id  = "AllowS3Invocation"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_processor_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.landing_bucket}"
}

resource "aws_s3_bucket_notification" "landing_bucket_notification" {
  bucket = var.landing_bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_processor_lambda.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ""
    filter_prefix       = ""
  }

  depends_on = [
    aws_lambda_function.s3_processor_lambda,
    aws_lambda_permission.allow_s3_invocation
  ]
}
