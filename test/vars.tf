variable "AMI_ID" {}
variable "TYPE" {}
variable "REGION" {}
variable "avail_zones" {
    type = list(string)
}
variable "subnet_cidrs" {
    type = list(string)
}
variable "private_ips" {
    type = list(string)
}
