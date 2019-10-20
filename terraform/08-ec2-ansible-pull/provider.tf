provider "aws" {}

terraform {
  backend "s3" {
    bucket = "terraform-batch35"
    key    = "08-ec2/terraform.tfstate"
    region = "us-east-1"
  }
}