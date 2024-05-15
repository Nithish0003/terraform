# creating auto-scaling group
resource "aws_autoscaling_group" "asg" {
  count               = 2
  name                = "asg-${count.index + 1}"
  max_size            = 1
  min_size            = 1
  desired_capacity    = 1
  target_group_arns   = [aws_lb_target_group.tg[count.index].arn]
  vpc_zone_identifier = [aws_subnet.subnet["subnet-${count.index + 1}"].id, aws_subnet.subnet["subnet-${count.index + 2}"].id]
  launch_template {
    id = aws_launch_template.template["template-${count.index + 1}"].id
  }
}