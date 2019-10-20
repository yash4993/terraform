resource "aws_vpc_peering_connection" "peer-with-default" {
  peer_owner_id = "${data.aws_caller_identity.current.account_id}"
  peer_vpc_id   = "${data.aws_vpc.default-vpc.id}"
  vpc_id        = "${aws_vpc.studentapp-vpc.id}"
  auto_accept   = true

  tags = {
    Name = "VPC Peering between default and studentapp vpc"
  }
}
