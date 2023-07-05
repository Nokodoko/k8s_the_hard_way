terraform {
  required_providers {
    aws = {
            source = "hashicorp/aws"
        }
  }
  backend "s3" {
      bucket = "cka-backend"
      key = "terraform-backend/backend"
      region = "us-east-1"
      encrypt = true
  }
}

provider "aws" {
    region = var.region
}
