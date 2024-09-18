
resource "aws_iam_role" "csv_ingestion_role" {
  name = "csv_ingestion_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "csv_ingestion_policy" {
  name = "csv_ingestion_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = "${var.bucket_arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "csv_ingestion_attachment" {
  role       = aws_iam_role.csv_ingestion_role.name
  policy_arn = aws_iam_policy.csv_ingestion_policy.arn
}
