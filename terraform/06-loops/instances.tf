resource "aws_instance" "node" {
  count         = 2  
  ami           = "ami-0814212f23c2be1d1"
  instance_type = "t2.micro"
  key_name      = "devops"

  tags = {
    Name = "Instance-${count.index+1}"
  }
}

