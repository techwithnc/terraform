variable "ec2-type" {}
variable "region" {}
variable "vpc-block" {
  
}
variable "env-prefix" {}
variable "avail_zones" {
    type = list(string)
}
variable "subnet_cidrs" {
    type = list(string)
}
variable "private_ips" {
    type = list(string)
}
variable "key-location" {}
