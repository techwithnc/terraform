// module for instance
resource "aws_instance" "instance01" {
    ami = "${var.AMI_ID}"
    instance_type = "${var.TYPE}"
    availability_zone = "${var.A_ZONE}"
    subnet_id   = "${var.SUBNET_ID}"
    private_ip = "${var.PRI_IP}"
    vpc_security_group_ids = ["${var.SCR_GP}"]
    tags = {
        Name = "aws_ubt01"
    }  
}
