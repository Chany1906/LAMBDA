resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "PermitirEjecucionDesdeS3"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3.input_bucket_arn
}