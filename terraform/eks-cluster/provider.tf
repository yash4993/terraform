provider "aws" {
    region     = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-batch35"
    key    = "eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}