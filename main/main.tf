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
module "instance_module" {
  source = "../modules/instance"
  AMI_ID = "${var.AMI_ID}"
  TYPE = "${var.TYPE}"
  A_ZONE = "${var.A_ZONE}"
  SUBNET_ID = "${module.networking_module.subnet_id}"
  PRI_IP = "${var.PRI_IP}"
  SCR_GP = "${module.networking_module.sg_id}"
}
module "networking_module" {
  source = "../modules/networking"
  VPC_CIDR = "${var.VPC_CIDR}"
  TENANCY = "${var.TENANCY}"
  SUBNET_CIDR = "${var.SUBNET_CIDR}"
  A_ZONE = "${var.A_ZONE}"
  IGS_P1 = "${var.IGS_P1}"
  IGS_P2 = "${var.IGS_P2}"
  IGS_P3 = "${var.IGS_P3}"
  IGS_P4 = "${var.IGS_P4}"
  PTC = "${var.PTC}"
  INST_ID = "${module.instance_module.inst_id}"
  PRI_IP = "${var.PRI_IP}"
}
module "storage_module"{
  source = "../modules/storage"
}
module "loadbalancer_module"{
  source = "../modules/loadbalancer"
  SCR_GP = "${module.networking_module.sg_id}"
  SUBNET_ID = "${module.networking_module.subnet_id}"
  SUBNET_ID_2 = "${module.networking_module.subnet_id_2}"
  VPC_ID = "${module.networking_module.vpc_id}"
  INST_ID = "${module.instance_module.inst_id}"
  INST_ID_2 = "${module.instance_module.inst_id_2}"
}