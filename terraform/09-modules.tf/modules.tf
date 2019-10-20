module "s3" {
  source  = "./Modules/s3"
  bucket_name = "${var.bucket_name}"
}

module "ec2" {
  source  = "./Modules/ec2"
  s3-arn = "${module.s3.s3-arn}"
}
