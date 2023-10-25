module "apigw" {
  source                      = "./modules/apigw"
  apigw_name                  = "apigw_lambda"
  apigw_protocol              = "HTTP"
  apigw_stage_name            = "health_check"
  apigw_auto_deployment       = true
  apigw_integration_uri       = module.lambda.function_arn
  apigw_integration_type      = "AWS_PROXY"
  apigw_route_key             = "GET /status"
  lambda_func_name            = module.lambda.function_name
  apigw_logs                  = "/aws/api_gw/${var.func_name}"
  apigw_logs_retention        = 30
}
