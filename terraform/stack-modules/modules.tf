module "network" {
  source  = "./Modules/network"
  PROJECT_NAME      = "${var.PROJECT_NAME}"
  PROJECT_ENV       = "${var.PROJECT_ENV}"
  VPC_CIDR          = "${var.VPC_CIDR}"
  AZ                = "${var.AZ}"
}


module "database" {
  source  = "./Modules/database"
  PROJECT_NAME         = "${var.PROJECT_NAME}"
  PROJECT_ENV          = "${var.PROJECT_ENV}"
  VPC_CIDR             = "${var.VPC_CIDR}"
  AZ                   = "${var.AZ}"
  DB_SIZE              =  "${var.DB_SIZE}"
  DB_ENGINE            =  "${var.DB_ENGINE}"
  DB_ENGINE_VERSION    =  "${var.DB_ENGINE_VERSION}"
  NEED_FINAL_SNAPSHOT  =  "${var.NEED_FINAL_SNAPSHOT}"
  DBNAME               =  "${var.DBNAME}"
  DBUSER               =  "${var.DBUSER}"
  DBPASS               =  "${var.DBPASS}"
  DB_INSTANCE_TYPE     =  "${var.DB_INSTANCE_TYPE}"
  RDS_DB_NAME          =  "${var.RDS_DB_NAME}"
  PRIVATE_SUBNETS      =  "${module.network.private-subnets}"
  VPC_ID               =  "${module.network.vpc-id}"
  DEFAULT_VPC_CIDR     =  "${module.network.default-vpc-cidr}"
}

module "infra" {
  source               =  "./Modules/infrastructure"
  PROJECT_NAME         =  "${var.PROJECT_NAME}"
  PROJECT_ENV          =  "${var.PROJECT_ENV}"
  VPC_CIDR             =  "${var.VPC_CIDR}"
  AZ                   =  "${var.AZ}"
  INSTANCE_TYPE        =  "${var.INSTANCE_TYPE}"
  KEYPAIR_NAME         =  "${var.KEYPAIR_NAME}"
  INSTANCE_COUNT       =  "${var.INSTANCE_COUNT}"
  PUBLIC_SUBNETS       =  "${module.network.public-subnets}"
  VPC_ID               =  "${module.network.vpc-id}"
  DEFAULT_VPC_CIDR     =  "${module.network.default-vpc-cidr}"
  DBNAME               =  "${var.DBNAME}"
  DBUSER               =  "${var.DBUSER}"
  DBPASS               =  "${var.DBPASS}"
  DBHOST               =  "${module.database.rds-endpoint}"
  WEBAPP_NEXUS_URL     =  "${var.WEBAPP_NEXUS_URL}"
}