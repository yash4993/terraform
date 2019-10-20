provider "aws" {}

terraform {
  backend "s3" {
    bucket = "terraform-batch35"
    key    = "09-modules/terraform.tfstate"
    region = "us-east-1"
  }
}