
provider "aws" {
  region = "eu-west-1"
}

module "storage" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name
}
