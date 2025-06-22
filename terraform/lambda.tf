resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_lambda_function" "process_file" {
  function_name = "process_file_lambda"
  runtime = "python3.9"
  role = aws_iam_role.lambda_exec.arn
  handler = "handler.lambda_handler"
  filename = "../lambda/lambda.zip"
  source_code_hash = filebase64sha256("../lambda/lambda.zip")
}

#no olvidar editar esta parte

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_file.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.data_bucket.arn
}
