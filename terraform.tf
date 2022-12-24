terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-provider-cinco"
    key = "cincoaws/terraform.tfstate"
    region = "us-east-1"
  }
}