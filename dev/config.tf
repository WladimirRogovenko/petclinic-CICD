terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

terraform {
    backend "s3" {
    bucket = "tfstate-final-project-java2022"  #bucket s3 name for TF state
    key ="global/s3/dev/terraform.tfstate"   #where in s3
    region = "eu-west-3"
    #dynamodb_table = "terraform-up-and-runninglocks"  #my table name in DynamoDB
    encrypt = true
    }
}