resource "aws_db_parameter_group" "default" {
  name        = "mariadb-parameter-group"
  family      = "mariadb10.3"
  description = "RDS MariaDB cluster parameter group"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["${var.PRIVATE_SUBNETS}"]

  tags = {
    Name            = "${var.PROJECT_NAME}-${var.PROJECT_ENV}-Subnet-Group"
    PROJECT_NAME    = "${var.PROJECT_NAME}"
    ENVIRONMENT     = "${var.PROJECT_ENV}"
    Created_BY      = "Terraform"
  }

}

resource "aws_security_group" "allow_rds" {
  name        = "mariadb-rds"
  description = "Allow MariaDB inbound traffic"
  vpc_id      = "${var.VPC_ID}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["${var.VPC_CIDR}", "${var.DEFAULT_VPC_CIDR}"]
  }
  tags = {
    Name            = "${var.PROJECT_NAME}-${var.PROJECT_ENV}-Security-Group"
    PROJECT_NAME    = "${var.PROJECT_NAME}"
    ENVIRONMENT     = "${var.PROJECT_ENV}"
    Created_BY      = "Terraform"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage       = "${var.DB_SIZE}"
  storage_type            = "gp2"
  engine                  = "${var.DB_ENGINE}"
  engine_version          = "${var.DB_ENGINE_VERSION}"
  instance_class          = "${var.DB_INSTANCE_TYPE}"
  name                    = "${var.DBNAME}"
  username                = "${var.DBUSER}"
  password                = "${var.DBPASS}"
  parameter_group_name    = "${aws_db_parameter_group.default.id}"
  skip_final_snapshot     = "${! var.NEED_FINAL_SNAPSHOT}"
  identifier              = "${var.RDS_DB_NAME}"
  db_subnet_group_name    = "${aws_db_subnet_group.default.id}"
  vpc_security_group_ids  = ["${aws_security_group.allow_rds.id}"]
}


resource "null_resource" "scheme-load" {
  provisioner "local-exec" {
    command = <<EOF
      mysql -h ${aws_db_instance.default.address} -u ${var.DBUSER} -p${var.DBPASS} < Modules/database/schema.sql
EOF
  }
}