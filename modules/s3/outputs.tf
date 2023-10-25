output "s3_bucket_id" {
  value = aws_s3_bucket.lambda_bucket.id
}

output "s3_bucket_key" {
  value = aws_s3_object.lambda_status.key
}

output "s3_bucket_lambda_arn" {
  value = aws_s3_bucket.lambda_bucket.arn
}

output "s3_bucket_codepipeline_arn" {
  value = aws_s3_bucket.pipeline_bucket.arn
}

output "s3_bucket_tfstate_arn" {
  value = aws_s3_bucket.tfstate_bucket.arn
}
