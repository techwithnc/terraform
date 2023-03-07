// module for networking
resource "aws_vpc" "vpc01" {
  cidr_block       = "${var.VPC_CIDR}"
  instance_tenancy = "${var.TENANCY}"

  tags = {
    Name = "aws_vpc01"
  }
}
resource "aws_subnet" "subnet01" {
  vpc_id     = aws_vpc.vpc01.id
  cidr_block = "${var.SUBNET_CIDR}"
  availability_zone = "${var.A_ZONE}"
  tags = {
    Name = "aws_subnet01"
  }
}
resource "aws_security_group" "sg01" {
  name        = "allow_web-traffic"
  description = "Allow web-traffice inbound traffic"
  vpc_id      = aws_vpc.vpc01.id

  ingress {
    description      = "https from world"
    from_port        = "${var.IGS_P1}"
    to_port          = "${var.IGS_P1}"
    protocol         = "${var.PTC}"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "http from world"
    from_port        = "${var.IGS_P2}"
    to_port          = "${var.IGS_P2}"
    protocol         = "${var.PTC}"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "ssh from world"
    from_port        = "${var.IGS_P3}"
    to_port          = "${var.IGS_P4}"
    protocol         = "${var.PTC}"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web-traffic"
  }
}
resource "aws_internet_gateway" "gw01" {
  vpc_id = aws_vpc.vpc01.id

  tags = {
    Name = "aws-gw01"
  }
}
resource "aws_route_table" "rtable01" {
  vpc_id = aws_vpc.vpc01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw01.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.gw01.id
  }

  tags = {
    Name = "aws_rtable01"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.rtable01.id
}
resource "aws_eip" "eip01" {
  vpc                       = true
  instance = "${var.INST_ID}"
  associate_with_private_ip = "${var.PRI_IP}"
  depends_on = [aws_internet_gateway.gw01]
}