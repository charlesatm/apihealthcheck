module "s3" {
  source                      = "./modules/s3"
  tfstate_bucket_name         = "${var.project}-tfstate-terraform" #please change the bucket name in terraform.tf backend block as it does not support variables
  lambda_s3_bucket_name       = "nodejs-lambda-bucket"
  codepipeline_bucket_name    = "${var.project}-awscodepipeline-bucket"
  lambda_s3_object_name       = "${var.func_name}.zip"
  lambda_source               = data.archive_file.zip_lambda.output_path
}
