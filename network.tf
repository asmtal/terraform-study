
# Availability Zone
data "aws_availability_zones" "az" {}

## VPC
resource "aws_vpc" "main" {
    cidr_block = "${cidrsubnet(var.cidr["vpc"], var.newbit, var.vpc_number[var.region])}"

    tags {
        Name = "${var.name}-${terraform.env}"
        Environment = "${terraform.env}"
    }
}

## EIP
resource "aws_eip" "nat_gateway" {
    count = "${length(data.aws_availability_zones.az.names)}"
}

## Gateways

### Internet Gateway
resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${var.name}-${terraform.env}"
        Environment = "${terraform.env}"
    }
}

### NAT Gateway
resource "aws_nat_gateway" "private" {
    count = "${length(data.aws_availability_zones.az.names)}"
    allocation_id = "${aws_eip.nat_gateway.*.id[count.index]}"
    subnet_id = "${aws_subnet.public.*.id[count.index]}"

    depends_on = ["aws_internet_gateway.main"]
}

## Subnets

### Public Subnet
resource "aws_subnet" "public" {
    vpc_id = "${aws_vpc.main.id}"

    count = "${length(data.aws_availability_zones.az.names)}"

    cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, var.newbit, count.index)}"
    availability_zone = "${data.aws_availability_zones.az.names[count.index]}"

    tags {
        Name = "${var.name}-${terraform.env}-public-${count.index}"
        Environment = "${terraform.env}"
    }
}

### Private Subnet
resource "aws_subnet" "private" {
    vpc_id = "${aws_vpc.main.id}"

    count = "${length(data.aws_availability_zones.az.names)}"

    cidr_block = "${cidrsubnet(aws_vpc.main.cidr_block, var.newbit, count.index)}"
    availability_zone = "${data.aws_availability_zones.az.names[count.index]}"

    tags {
        Name = "${var.name}-${terraform.env}-public-${count.index}"
        Environment = "${terraform.env}"
    }
}

