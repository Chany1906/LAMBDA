module "s3" {
  source = "git::https://oauth2:${var.github_token}@github.com/Chany1906/aws_s3.git"
  #source     = "https://github.com/Chany1906/aws_s3.git"
  lambda_arn = module.lambda.lambda_arn
}

module "lambda" {
  source = "git::https://oauth2:${var.github_token}@github.com/Chany1906/aws-lambda.git"
  #source           = "https://github.com/Chany1906/aws-lambda.git"
  input_bucket_arn = module.s3.input_bucket_arn
  output_bucket_arn = module.s3.output_bucket_arn
}

module "ec2" {
  source = "git::https://oauth2:${var.github_token}@github.com/Chany1906/aws_ec2.git"
  #source           = "https://github.com/Chany1906/aws_ec2.git"
  output_bucket_arn = module.s3.output_bucket_arn
}
variable "token_github" {
  type = string
}