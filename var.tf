variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "us-east-2"
}

variable "func_name" {
  description = "Name of the Lambda function"

  type    = string
  default = "apihealthcheck"
}

variable "project" {
  description = "Project Name"

  type    = string
  default = "kodez"
}

#Config related to the Github repository
locals {
  github_owner = "charlesatm"
  github_repo = "apihealthcheck"
  github_branch = "main"
}