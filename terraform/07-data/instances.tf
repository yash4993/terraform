resource "aws_instance" "node" {
  count         = 2  
  ami           = "ami-0814212f23c2be1d1"
  instance_type = "t2.micro"
  key_name      = "devops"
  subnet_id     = "${data.aws_subnet_ids.subnets.ids[count.index]}"

  tags = {
    Name = "Instance-${count.index+1}"
  }
}

