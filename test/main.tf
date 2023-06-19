// DEV environment
terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
        }
    }
}
provider "aws"{
    region = "${var.region}"
}
//////////////////////////////////////////////////////////
data "aws_ami" "amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
//////////////////////////////////////////////////////////
resource "aws_instance" "instance01" {
    ami = data.aws_ami.amazon-linux-image.id
    instance_type = "${var.ec2-type}"
    availability_zone = "${var.avail_zones[0]}"
    subnet_id   = aws_subnet.subnet01.id
    private_ip = "${var.private_ips[0]}"
    associate_public_ip_address = true
    user_data = file("entry-script.sh")
    key_name = aws_key_pair.key01.key_name
    vpc_security_group_ids = [aws_security_group.sg01.id]
    tags = {
      Name = "${var.env-prefix}-instance01"
    }
}
//////////////////////////////////////////////////////////
resource "aws_instance" "instance02" {
    ami = data.aws_ami.amazon-linux-image.id
    instance_type = "${var.ec2-type}"
    availability_zone = "${var.avail_zones[1]}"
    subnet_id   = aws_subnet.subnet02.id
    private_ip = "${var.private_ips[1]}"
    associate_public_ip_address = true
    key_name = aws_key_pair.key01.key_name
    vpc_security_group_ids = [aws_security_group.sg01.id]
    tags = {
      Name = "${var.env-prefix}-instance02"
    }
}
//////////////////////////////////////////////////////////
resource "aws_vpc" "vpc01" {
  cidr_block       = "${var.vpc-block}"
  tags = {
      Name = "${var.env-prefix}-vpc01"
    }
}
resource "aws_subnet" "subnet01" {
  vpc_id     = aws_vpc.vpc01.id
  cidr_block = "${var.subnet_cidrs[0]}"
  availability_zone = "${var.avail_zones[0]}"
  tags = {
      Name = "${var.env-prefix}-subnet01"
    }
}
resource "aws_subnet" "subnet02" {
  vpc_id     = aws_vpc.vpc01.id
  cidr_block = "${var.subnet_cidrs[1]}"
  availability_zone = "${var.avail_zones[1]}"
  tags = {
      Name = "${var.env-prefix}-subnet02"
    }
}
resource "aws_security_group" "sg01" {
  name   = "security-group01"
  vpc_id = aws_vpc.vpc01.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.env-prefix}-sg01"
  }
}
resource "aws_internet_gateway" "igw01" {
	vpc_id = aws_vpc.vpc01.id
    
    tags = {
     Name = "${var.env-prefix}-internet-gateway"
   }
}

resource "aws_route_table" "rtb01" {
   vpc_id = aws_vpc.vpc01.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.igw01.id
   }

   # default route, mapping VPC CIDR block to "local", created implicitly and cannot be specified.

   tags = {
     Name = "${var.env-prefix}-route-table"
   }
 }

# Associate subnet with Route Table
resource "aws_route_table_association" "subnet01" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.rtb01.id
}
resource "aws_route_table_association" "subnet02" {
  subnet_id      = aws_subnet.subnet02.id
  route_table_id = aws_route_table.rtb01.id
}
//////////////////////////////////////////////////////////
resource "aws_key_pair" "key01" {
  key_name   = "sshkey01"
  public_key = file(var.key-location)
}


