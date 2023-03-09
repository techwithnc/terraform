// module for instance
resource "aws_instance" "instance01" {
    ami = "${var.AMI_ID}"
    instance_type = "${var.TYPE}"
    availability_zone = "${var.A_ZONE}"
    subnet_id   = "${var.SUBNET_ID}"
    private_ip = "${var.PRI_IP}"
    vpc_security_group_ids = ["${var.SCR_GP}"]
    user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 1" > index.html
              python3 -m http.server 8080 &
              EOF
    tags = {
        Name = "ubt01"
    }  
}
resource "aws_instance" "instance02" {
    ami = "${var.AMI_ID}"
    instance_type = "${var.TYPE}"
    availability_zone = "${var.A_ZONE_2}"
    subnet_id   = "${var.SUBNET_ID_2}"
    private_ip = "${var.PRI_IP_2}"
    vpc_security_group_ids = ["${var.SCR_GP}"]
    user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 2" > index.html
              python3 -m http.server 8080 &
              EOF
    tags = {
        Name = "ubt02"
    }  
}
