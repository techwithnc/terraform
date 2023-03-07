// TEST environment
terraform{
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "4.56.0"
        }
    }
}
provider "aws"{
    region = "ap-southeast-2"
}
module "instance_module" {
  source = "../modules/instance"
  AMI_ID = "ami-08f0bc76ca5236b20"
  TYPE = "t2.micro"
  A_ZONE = "ap-southeast-2b"
  SUBNET_ID = "${module.networking_module.subnet_id}"
  PRI_IP = "192.168.1.123"
  SCR_GP = "${module.networking_module.sg_id}"

}
module "networking_module" {
  source = "../modules/networking"
  VPC_CIDR = "192.168.0.0/16"
  TENANCY = "default"
  SUBNET_CIDR = "192.168.1.0/24"
  A_ZONE = "ap-southeast-2b"
  IGS_P1 = "443"
  IGS_P2 = "80"
  IGS_P3 = "22"
  IGS_P4 = "25"
  PTC = "tcp"
  INST_ID = "${module.instance_module.inst_id}"
  PRI_IP = "192.168.1.123"
}