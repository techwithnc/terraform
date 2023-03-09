output "subnet_id" {
  value = aws_subnet.subnet01.id
}
output "subnet_id_2" {
  value = aws_subnet.subnet02.id
}
output "sg_id" {
  value = aws_security_group.sg01.id
}
output "vpc_id" {
  value = aws_vpc.vpc01.id
}