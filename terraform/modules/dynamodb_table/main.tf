resource "aws_dynamodb_table" "metadata_table" {
  name           = "talosi-datalake-metadata-${var.env}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "stream_id"

  attribute {
    name = "stream_id"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  global_secondary_index {
    name            = "timestamp-index"
    hash_key        = "timestamp"
    projection_type = "ALL"
  }

  tags = {
    Environment = var.env
  }
}
