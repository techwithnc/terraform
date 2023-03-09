// DEV environment
terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "4.56.0"
        }
    }
}
provider "aws"{
    region = "${var.REGION}"
}
// module for instance
resource "aws_instance" "instance01" {
    ami = "${var.AMI_ID}"
    instance_type = "${var.TYPE}"
    availability_zone = "${var.avail_zones[0]}"
    subnet_id   = aws_subnet.subnet01.id
    private_ip = "${var.private_ips[0]}"
}
resource "aws_instance" "instance02" {
    ami = "${var.AMI_ID}"
    instance_type = "${var.TYPE}"
    availability_zone = "${var.avail_zones[1]}"
    subnet_id   = aws_subnet.subnet02.id
    private_ip = "${var.private_ips[1]}"
}
resource "aws_vpc" "vpc01" {
  cidr_block       = "172.16.0.0/16"
}
resource "aws_subnet" "subnet01" {
  vpc_id     = aws_vpc.vpc01.id
  cidr_block = "${var.subnet_cidrs[0]}"
  availability_zone = "${var.avail_zones[0]}"
}
resource "aws_subnet" "subnet02" {
  vpc_id     = aws_vpc.vpc01.id
  cidr_block = "${var.subnet_cidrs[1]}"
  availability_zone = "${var.avail_zones[1]}"
}
