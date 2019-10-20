resource "null_resource" "example1" {

    depends_on = ["aws_autoscaling_group.demo", "local_file.foo"] 
  provisioner "local-exec" {
    command = <<EOT
      aws eks update-kubeconfig --name ekscluster
      kubectl create -f config.yml
    EOT
  }
}

resource "local_file" "foo" {
    content     = "${local.config_map_aws_auth}"
    filename = "config.yml"
}
