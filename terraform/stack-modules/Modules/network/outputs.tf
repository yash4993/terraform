output "private-subnets" {
  value = "${aws_subnet.private-subnets.*.id}"
}

output "vpc-id" {
  value = "${aws_vpc.studentapp-vpc.id}"
}

output "default-vpc-cidr" {
  value = "${data.aws_vpc.default-vpc.cidr_block}"
}

output "public-subnets" {
  value = "${aws_subnet.public-subnets.*.id}"
}