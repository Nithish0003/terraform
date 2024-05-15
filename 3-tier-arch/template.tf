# creating template
resource "aws_launch_template" "template" {
  name          = each.value.name
  image_id      = data.aws_ami.ami.id
  instance_type = "t2.micro"
  key_name      = "mumbai"
  user_data     = filebase64("data.sh")
  network_interfaces {
    associate_public_ip_address = each.value.public_ip
    security_groups             = [aws_security_group.sg_1.id]
  }
  for_each = { for data in var.template : data.name => data }
}