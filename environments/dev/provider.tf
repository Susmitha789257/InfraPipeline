terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "susmitha7892557"
    key    = "environments/dev/terraform.tfstate"
    region = "ap-northeast-3"
  }
}

provider "aws" {
  region = "ap-northeast-3"
}

