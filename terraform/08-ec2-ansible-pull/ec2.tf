resource "aws_instance" "node" {
  ami           = "ami-0814212f23c2be1d1"
  instance_type = "t2.micro"
  key_name      = "devops"
  vpc_security_group_ids = ["sg-06895e4a713efcdd5"]

  tags = {
    Name = "Instance-${count.index+1}"
  }
}

resource "null_resource" "connection-to-ec2" {

    connection {
        type     = "ssh"
        user     = "centos"
        host     = "${aws_instance.node.public_ip}"
        private_key = "${file("/opt/devops.pem")}"
    }
    
    provisioner "file" {
        source      = "/opt/batch35.pem"
        destination = "/home/centos/.ssh/id_rsa"
    }


    provisioner "remote-exec" {
    inline = [
      "sudo yum install git ansible -y",
      "sudo chmod 600 /home/centos/.ssh/id_rsa",
      "ansible-pull --accept-host-key -U git@gitlab.com:batch35/ansible-pull.git setup.yml"
    ]
  }
}