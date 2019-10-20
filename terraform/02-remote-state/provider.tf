provider "aws" {}

terraform {
  backend "s3" {
    bucket = "terraform-batch35"
    key    = "02-remote-state/terraform.tfstate"
    region = "us-east-1"
  }
}