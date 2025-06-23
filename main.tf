resource "aws_lambda_function" "csv_processor" {
  function_name = "procesador-csv"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_role.arn
  filename      = "lambda_function.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "rol_ejecucion_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:GetObject"],
        Resource = "${var.input_bucket_arn}/*"
      },
      {
        Effect = "Allow",
        Action = ["s3:PutObject"],
        Resource = "${var.output_bucket_arn}/*"
      },
      {
        Effect = "Allow",
        Action = ["dynamodb:PutItem"],
        Resource = aws_dynamodb_table.historial_ejecucion.arn
      }
    ]
  })
}

resource "aws_dynamodb_table" "historial_ejecucion" {
  name           = "HistorialEjecucion"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "nombre_archivo"
  attribute {
    name = "nombre_archivo"
    type = "S"
  }
}