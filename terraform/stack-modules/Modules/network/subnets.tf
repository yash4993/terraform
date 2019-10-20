resource "aws_subnet" "public-subnets" {
    count                   = 4
    vpc_id                  = "${aws_vpc.studentapp-vpc.id}"
    cidr_block              = "${cidrsubnet("10.0.0.0/21", 3, count.index)}"
    availability_zone       = "${element(var.AZ, count.index)}"
    map_public_ip_on_launch = true

    tags = {
        Name            = "Public-Subnet-${count.index+1}"
        PROJECT_NAME    = "${var.PROJECT_NAME}"
        ENVIRONMENT     = "${var.PROJECT_ENV}"
        Created_BY      = "Terraform"
    }
}

resource "aws_subnet" "private-subnets" {
    count               = 4
    vpc_id              = "${aws_vpc.studentapp-vpc.id}"
    cidr_block          = "${cidrsubnet("10.0.0.0/21", 3, count.index+4)}"
    availability_zone   = "${element(var.AZ, count.index)}"

    tags = {
        Name            = "Private-Subnet-${count.index+1}"
        PROJECT_NAME    = "${var.PROJECT_NAME}"
        ENVIRONMENT     = "${var.PROJECT_ENV}"
        Created_BY      = "Terraform"
    }
}


resource "aws_route_table" "public-rt" {
    vpc_id          = "${aws_vpc.studentapp-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    route {
        cidr_block = "${data.aws_vpc.default-vpc.cidr_block }"
        gateway_id = "${aws_vpc_peering_connection.peer-with-default.id}"
    }

  tags = {
        Name            = "Public-Route-Table-${var.PROJECT_NAME}-${var.PROJECT_ENV}"
        PROJECT_NAME    = "${var.PROJECT_NAME}"
        ENVIRONMENT     = "${var.PROJECT_ENV}"
        Created_BY      = "Terraform"
  }
}

resource "aws_route_table" "private-rt" {
    vpc_id          = "${aws_vpc.studentapp-vpc.id}"

    route {
        cidr_block = "${data.aws_vpc.default-vpc.cidr_block }"
        gateway_id = "${aws_vpc_peering_connection.peer-with-default.id}"
    }

  tags = {
        Name            = "Private-Route-Table-${var.PROJECT_NAME}-${var.PROJECT_ENV}"
        PROJECT_NAME    = "${var.PROJECT_NAME}"
        ENVIRONMENT     = "${var.PROJECT_ENV}"
        Created_BY      = "Terraform"
  }
}


resource "aws_route_table_association" "public-a" {
    count           = 4 
    subnet_id       = "${element(aws_subnet.public-subnets.*.id, count.index)}"
    route_table_id  = "${aws_route_table.public-rt.id}"
}

resource "aws_route_table_association" "private-a" {
    count           = 4 
    subnet_id       = "${element(aws_subnet.private-subnets.*.id, count.index)}"
    route_table_id  = "${aws_route_table.private-rt.id}"
}

resource "aws_route" "r" {
  count = 1
  route_table_id            = "${data.aws_route_table.selected.id}"
  destination_cidr_block    = "${var.VPC_CIDR}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer-with-default.id}"
}