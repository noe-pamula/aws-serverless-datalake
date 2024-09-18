
provider "aws" {
  region = "eu-west-1"
}

module "storage" {
  source = "./modules/s3_bucket"
  env    = var.env
  bu     = "supply"
}

# module "acquisition_kinesis_firehose" {
#   source        = "./modules/kinesis_firehose"
#   firehose_name = var.firehose_name
#   bucket_arn    = module.storage.landing_bucket_arn
# }

# module "aquisition_csv_file" {
#   source     = "./modules/csv_ingestion"
#   bucket_arn = module.storage.landing_bucket_arn
# }

# module "partage_api" {
#   source    = "./modules/api_gateway"
#   bucket_id = module.storage.bucket_id
# }

module "dynamodb_table" {
  source = "./modules/dynamodb_table"
  env = var.env
}

module "s3_lambda_processor" {
  source        = "./modules/ingestion_s3"
  landing_bucket = module.storage.landing_bucket_name
  raw_bucket     = module.storage.raw_bucket_name
  table_name     = "talosi-datalake-metadata-${var.env}"
  region         = "eu-west-1"
  dynamodb_table_arn = module.dynamodb_table.dynamodb_table_arn
}

