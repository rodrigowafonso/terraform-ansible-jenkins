terraform {

backend "s3" {

    # A configuração do Backend Terraform State será provisionado no S3
    
}

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}