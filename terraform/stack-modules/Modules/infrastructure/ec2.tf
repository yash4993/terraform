resource "aws_instance" "nodes" {
  count                     = "${var.INSTANCE_COUNT}"
  ami                       = "${data.aws_ami.ami.id}"
  instance_type             = "${var.INSTANCE_TYPE}"
  key_name                  = "${var.KEYPAIR_NAME}"
  subnet_id                 = "${element(var.PUBLIC_SUBNETS, count.index)}"
  vpc_security_group_ids    = ["${aws_security_group.allow_ec2.id}"]
  tags = {
    Name                = "${var.PROJECT_NAME}-${var.PROJECT_ENV}-Instance-${count.index+1}"
    PROJECT_NAME        = "${var.PROJECT_NAME}"
    ENVIRONMENT         = "${var.PROJECT_ENV}"
    Created_BY          = "Terraform"
  }
}

resource "local_file" "foo" {
  count                     = "${var.INSTANCE_COUNT}"
    content     = "${element(aws_instance.nodes.*.public_ip, count.index)}"
    filename    = "/outputs/public-ip.txt"
}

resource "null_resource" "connection-to-ec2" {
    count                     = "${var.INSTANCE_COUNT}"
    connection {
        type                  = "ssh"
        user                  = "centos"
        host                  = "${element(aws_instance.nodes.*.private_ip, count.index)}"
        private_key           = "${file("/home/jenkins/devops.pem")}"
    }
    
    provisioner "file" {
        source                = "/home/jenkins/devops.pem"
        destination           = "/home/centos/.ssh/id_rsa"
     }


    provisioner "remote-exec" {
    inline = [
      "sudo yum clean all",
      "sudo yum install git ansible -y",
      "sudo chmod 600 /home/centos/.ssh/id_rsa",
      "ansible-pull --accept-host-key -U git@gitlab.com:batch35/ansible-pull.git setup.yml -e DBUSER=${var.DBUSER} -e DBPASS=${var.DBPASS} -e DBHOST=${var.DBHOST} -e DBNAME=${var.DBNAME} -e UI_WAR_URL=${var.WEBAPP_NEXUS_URL}"
    ]
  }
}