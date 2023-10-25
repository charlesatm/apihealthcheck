resource "aws_lambda_function" "hello_world" {
  function_name = var.lambda_func_name

  s3_bucket = var.s3_bucket_id
  s3_key    = var.s3_bucket_key

  runtime = var.lambda_runtime
  handler = var.lambda_handler

  source_code_hash = var.lambda_src_code_hash

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "hello_world" {
  name = var.cloudwatch_log

  retention_in_days = var.cloudwatch_log_retention
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
