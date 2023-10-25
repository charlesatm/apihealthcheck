module "lambda" {
  source                      = "./modules/lambda"
  lambda_func_name            =  var.func_name
  lambda_s3_object_name       = "${var.func_name}.zip"
  lambda_source               = data.archive_file.zip_lambda.output_path
  lambda_src_code_hash        = data.archive_file.zip_lambda.output_base64sha256
  s3_bucket_id                = module.s3.s3_bucket_id
  s3_bucket_key               = module.s3.s3_bucket_key
  lambda_runtime              = "nodejs18.x"
  lambda_handler              = "${var.func_name}.handler"
  cloudwatch_log              = "/aws/lambda/${var.func_name}"
  cloudwatch_log_retention    = 30
}