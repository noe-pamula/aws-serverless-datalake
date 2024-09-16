resource "aws_s3_bucket" "lambda_deployment" {
  bucket = "talosi-lambda-deployment-bucket"
}

resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_deployment.bucket
  key    = "lambda_function.zip"
  source = "./lambda_function.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "athena:StartQueryExecution",
          "athena:GetQueryExecution",
          "athena:GetQueryResults",
          "s3:GetObject",
          "s3:PutObject",
          "s3:*",
          "glue:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "athena_query_function" {
  function_name = "athena_query_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "request.lambda_handler"
  runtime       = "python3.10"

  filename         = "./lambda_function.zip" 
  source_code_hash = filebase64sha256("./lambda_function.zip")

  environment {
    variables = {
      DATABASE         = "talosi_datalake"
      OUTPUT_LOCATION  = "s3://talosi-datalake-serverless/athena/"
    }
  }

  timeout = 30
}

resource "aws_apigatewayv2_api" "api" {
  name          = "athena_api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.athena_query_function.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "lambda_route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /query"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "dev"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.athena_query_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}