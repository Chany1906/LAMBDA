provider "aws" {
  region = "us-east-1"
}

resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
  numeric  = true
}

module "lambda" {
  source            = "git::https://github.com/Chany1906/aws-lambda.git?ref=main"
  input_bucket_arn  = module.s3.input_bucket_arn
  output_bucket_arn = module.s3.output_bucket_arn
  s3_bucket_name    = module.s3.bucket_name
  suffix            = random_string.suffix.result
}

module "s3" {
  source         = "git::https://github.com/Chany1906/aws_s3.git?ref=main"
  s3_bucket_name = "bucket-numero-002"
  suffix         = random_string.suffix.result
}

module "ec2" {
  source            = "git::https://github.com/Chany1906/aws_ec2.git?ref=main"
  output_bucket_arn = module.s3.output_bucket_arn
  suffix            = random_string.suffix.result
}
