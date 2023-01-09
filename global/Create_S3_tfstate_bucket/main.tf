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
  region = "eu-west-3"
}

#================= create bucket s3 for TF state =================================================

resource "aws_s3_bucket" "terraform_state" {
  bucket = "tfstate-final-project-java2022"
  lifecycle {
    #prevent_destroy = true #prevent randomly delete backet
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

/*
resource "aws_dynamodb_table" "terraform_locks"{
    name = "terraform-up-and-runninglocks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}


#before command "teraform init" this blok must be run ONLY after S3 has created
terraform {
    backend "s3" {
    bucket = "tfstate-final-project-java2022"  #my bucket s3 name
    key ="global/s3/terraform.tfstate"   #where in s3
    region = "eu-west-3"
    #dynamodb_table = "terraform-up-and-runninglocks"  #my table name in DynamoDB
    encrypt = true
    }
}
*/
#====================================================================================================