variable "DB_SIZE" {}
variable "DB_ENGINE" {}
variable "DB_ENGINE_VERSION" {}
variable "NEED_FINAL_SNAPSHOT" {}
variable "DBNAME" {}
variable "DBUSER" {}
variable "DBPASS" {}
variable "DB_INSTANCE_TYPE" {}
variable "RDS_DB_NAME" {}
variable "PRIVATE_SUBNETS" {
    type = "list"
}

variable "PROJECT_NAME" {}
variable "PROJECT_ENV" {}
variable "VPC_CIDR" {}
variable "AZ" {
    type = "list"
}

variable "VPC_ID" {}
variable "DEFAULT_VPC_CIDR" {}