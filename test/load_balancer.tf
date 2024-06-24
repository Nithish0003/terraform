# creating load balancer
resource "aws_lb" "alb" {
  name               = "alb-1"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_1.id]
  subnets            = [aws_subnet.vpc1_subnet["vpc1-subnet-1"].id,aws_subnet.vpc1_subnet["vpc1-subnet-2"].id]
}
# creating target group
resource "aws_lb_target_group" "tg_1" {
  name     = "tg-1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_1.id
}
# attaching instance-1
resource "aws_lb_target_group_attachment" "attachment-1" {
  target_group_arn = aws_lb_target_group.tg_1.arn
  target_id        = aws_instance.vpc1_instance["vpc1-test-1"].id
  port             = 80
}
# attaching instance-2
resource "aws_lb_target_group_attachment" "attachment-2" {
  target_group_arn = aws_lb_target_group.tg_1.arn
  target_id        = aws_instance.vpc1_instance["vpc1-test-2"].id
  port             = 80
}
# attaching alb listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_1.arn
  }
}