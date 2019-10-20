resource "null_resource" "null1" {
    provisioner "local-exec" {
    command = "echo Bucket ARN = ${var.s3-arn} "
  }
}