resource "aws_db_instance" "default" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.3"
  instance_class       = "db.t2.micro"
  name                 = "studentapp"
  username             = "student"
  password             = "student1"
  parameter_group_name = "default.mariadb10.3"
  skip_final_snapshot  = true
  identifier           = "studentapp-db"
}