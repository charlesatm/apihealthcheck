output "base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.lambda.invoke_url
}


output "apigw_arn" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_api.lambda.arn
}

output "apigw_stage_arn" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.lambda.arn
}

output "apigw_integration_id" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_integration.lambda.id
}

output "apigw_routes_id" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_route.lambda.id
}
