resource "aws_lb" "lb01" {
  name               = "loadbalaner01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.SCR_GP}"]
  subnets            = ["${var.SUBNET_ID}", "${var.SUBNET_ID_2}"]
  enable_deletion_protection = false
  tags = {
    Name = "lb01"
  }
}
resource "aws_lb_target_group" "tg01" {
  name     = "target01"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${var.VPC_ID}"
}
resource "aws_lb_target_group_attachment" "attch01" {
  target_group_arn = aws_lb_target_group.tg01.arn
  target_id        = "${var.INST_ID}"
  port             = 8080
}
resource "aws_lb_target_group_attachment" "attch02" {
  target_group_arn = aws_lb_target_group.tg01.arn
  target_id        = "${var.INST_ID_2}"
  port             = 8080
}
resource "aws_lb_listener" "ltn01" {
  load_balancer_arn = aws_lb.lb01.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg01.arn
  }
}