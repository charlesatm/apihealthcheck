resource "aws_s3_bucket" "pipeline_bucket" {
  bucket = var.codepipeline_bucket_name
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.lambda_s3_bucket_name
}

resource "aws_s3_object" "lambda_status" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = var.lambda_s3_object_name
  source = var.lambda_source
  etag = filemd5(var.lambda_source)
}


resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = var.tfstate_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}