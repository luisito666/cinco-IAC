# Provider y version de Terraform

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.25.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  default_tags {
    tags = {
      Environment = "${var.stack_id}"
      Project     = "${var.layer}"
      Owner       = "${var.profile}"
      Region      = "${var.region}"
      Terraform   = true
    }
  }
}