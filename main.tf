module "s3" {
  source     = "https://github.com/Chany1906/aws_s3.git?ref=main""
  lambda_arn = module.lambda.lambda_arn
}

module "lambda" {
  source           = "git::https://github.com/Chany1906/aws_s3.git?ref=main"
  input_bucket_arn = module.s3.input_bucket_arn
  output_bucket_arn = module.s3.output_bucket_arn
}

module "ec2" {
  source           = "git::https://github.com/Chany1906/aws_ec2.git?ref=main"
  output_bucket_arn = module.s3.output_bucket_arn
}
