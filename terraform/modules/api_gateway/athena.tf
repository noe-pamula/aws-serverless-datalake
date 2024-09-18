resource "aws_athena_database" "data_lake_db" {
  name   = "talosi_datalake"
  bucket = var.bucket_id
}

resource "aws_athena_workgroup" "primary" {
  name = "datalake"
}

resource "aws_glue_catalog_table" "csv_table" {
  name          = "users_table"
  database_name = aws_athena_database.data_lake_db.name

  table_type    = "EXTERNAL_TABLE"
  parameters    = {
    "external" = "TRUE"
  }

  storage_descriptor {
    columns {
      name = "userid"
      type = "string"
    }
    columns {
      name = "name"
        type = "string"
    }
    columns {
      name = "age"
        type = "int"
    }
    columns {
      name = "email"
        type = "string"
    }
    columns {
      name = "department"
        type = "string"
    }
    columns {
      name = "role"
        type = "string"
    }
    columns {
      name = "location"
        type = "string"
    }
    columns {
      name = "experience_years"
        type = "int"
    }
    columns {
      name = "active"
        type = "string"
    }
    

    location = "s3://${var.bucket_id}/uploads/"
    input_format = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    compressed = false
    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }
  }
}


resource "aws_iam_role" "api_gateway_role" {
  name = "api_gateway_athena_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "athena_policy" {
  name = "ApiGatewayAthenaPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "athena:StartQueryExecution",
          "athena:GetQueryExecution",
          "athena:GetQueryResults",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

