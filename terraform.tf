terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      version = "~> 4.0"
      source  = "hashicorp/aws"
    }
  }
/*    backend "s3" {

    bucket         	   = "kodez-tfstate-terraform" #refer to s3.tf file for the bucket name
    key              	 = "state/terraform.tfstate"
    region         	   = "us-east-2" #refer to var.tf file for the region name
    encrypt        	   = true

  } */
}
