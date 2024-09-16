
provider "aws" {
  region = "eu-west-1"
}

module "storage" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name
}

module "acquisition_kinesis_firehose" {
  source      = "./modules/kinesis_firehose"
  firehose_name = var.firehose_name
  bucket_arn = module.storage.bucket_arn
}

module "aquisition_csv_file" {
  source     = "./modules/csv_ingestion"
  bucket_arn = module.storage.bucket_arn
}

module "partage_api" {
  source     = "./modules/api_gateway"
  bucket_id = module.storage.bucket_id
}