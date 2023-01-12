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

#================= create bucket s3 for Artifacts storage =================================================

resource "aws_s3_bucket" "s3_artifacts_storage" {
  bucket = "p-petclinic2023-jenkins-archive-artifacts"
  lifecycle {
    #prevent_destroy = true #prevent randomly delete backet
  }
  versioning {
    enabled = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    "project" = "petclinic"
  }
}


#====================================================================================================