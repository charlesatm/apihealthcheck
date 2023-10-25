variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "us-east-2"
}

variable "func_name" {
  description = "AWS region for all resources."

  type    = string
  default = "status"
}

variable "project" {
  description = "AWS region for all resources."

  type    = string
  default = "kodez"
}


locals {
  github_owner = "charlesatm"
  github_repo = "testendpoint"
  github_branch = "main"
}