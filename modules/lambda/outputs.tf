output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.hello_world.function_name
}

output "function_arn" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.hello_world.arn
}