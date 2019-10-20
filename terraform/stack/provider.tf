provider "aws" {}

terraform {
  backend "s3" {
    bucket = "terraform-batch35"
    key    = "stack/terraform.tfstate"
    region = "us-east-1"
  }
}