module "s3" {
  source                      = "./modules/s3"
  tfstate_bucket_name         = "${var.project}-terraform-tfstates"
  lambda_s3_bucket_name       = "lambda-node-bucket"
  codepipeline_bucket_name    = "${var.project}-codepipeline-buckets"
  lambda_s3_object_name       = "${var.func_name}.zip"
  lambda_source               = data.archive_file.zip_lambda.output_path
}