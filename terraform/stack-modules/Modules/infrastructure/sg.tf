resource "aws_security_group" "allow_ec2" {
  name        = "ec2-sg"
  description = "Allow EC2 inbound traffic"
  vpc_id      = "${var.VPC_ID}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["${var.VPC_CIDR}", "${var.DEFAULT_VPC_CIDR}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0","${var.VPC_CIDR}", "${var.DEFAULT_VPC_CIDR}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name            = "${var.PROJECT_NAME}-${var.PROJECT_ENV}-EC2-Security-Group"
    PROJECT_NAME    = "${var.PROJECT_NAME}"
    ENVIRONMENT     = "${var.PROJECT_ENV}"
    Created_BY      = "Terraform"
  }
}