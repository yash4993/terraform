resource "aws_vpc" "studentapp-vpc" {
  cidr_block       = "${var.VPC_CIDR}"
  instance_tenancy = "default"

  tags = {
    Name            = "${var.PROJECT_NAME}-${var.PROJECT_ENV}-VPC"
    PROJECT_NAME    = "${var.PROJECT_NAME}"
    ENVIRONMENT     = "${var.PROJECT_ENV}"
    Created_BY      = "Terraform"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.studentapp-vpc.id}"

  tags = {
    Name            = "${var.PROJECT_NAME}-${var.PROJECT_ENV}-IGW"
    PROJECT_NAME    = "${var.PROJECT_NAME}"
    ENVIRONMENT     = "${var.PROJECT_ENV}"
    Created_BY      = "Terraform"
  }
}