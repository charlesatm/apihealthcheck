terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }
  }
    backend "s3" {

    bucket         	   = "kodez-terraform-tfstates"
    key              	 = "state/terraform.tfstate"
    region         	   = "us-east-2"
    encrypt        	   = true

  }
}