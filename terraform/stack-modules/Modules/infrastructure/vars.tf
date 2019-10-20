variable "PROJECT_NAME" {}
variable "PROJECT_ENV" {}
variable "VPC_CIDR" {}
variable "AZ" {
    type = "list"
}

data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${data.aws_caller_identity.current.account_id}"] # Canonical
}

variable "INSTANCE_TYPE" {}
variable "KEYPAIR_NAME" {}
variable "INSTANCE_COUNT" {}
variable "PUBLIC_SUBNETS" {
    type = "list"
}

variable "VPC_ID" {}
variable "DEFAULT_VPC_CIDR" {}
variable "DBNAME" {}
variable "DBUSER" {}
variable "DBPASS" {}
variable "DBHOST" {}
variable "WEBAPP_NEXUS_URL" {}