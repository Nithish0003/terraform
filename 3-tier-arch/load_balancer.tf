# creating load balancer
resource "aws_lb" "alb" {
  count              = 2
  name               = "alb-${count.index + 1}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_1.id]
  subnets            = [aws_subnet.subnet["subnet-${count.index + 1}"].id, aws_subnet.subnet["subnet-${count.index + 2}"].id]
}
# creating target group
resource "aws_lb_target_group" "tg" {
  count    = 2
  name     = "tg-${count.index}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test_vpc.id
}
# attaching instance-1,2
resource "aws_lb_target_group_attachment" "attachment-1" {
  count            = 2
  target_group_arn = aws_lb_target_group.tg[0].arn
  target_id        = aws_instance.test["test-${count.index + 1}"].id
  port             = 80
}
# attaching instance-3,4
resource "aws_lb_target_group_attachment" "attachment-2" {
  count            = 2
  target_group_arn = aws_lb_target_group.tg[1].arn
  target_id        = aws_instance.test["test-${count.index + 3}"].id
  port             = 80
}
# attaching alb listener
resource "aws_lb_listener" "alb_listener" {
  count             = 2
  load_balancer_arn = aws_lb.alb[count.index].arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[count.index].arn
  }
}