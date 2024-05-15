# copy public key
resource "aws_key_pair" "mumbai" {
  key_name   = "mumbai"
  public_key = var.key_pair
}
# creating instance
resource "aws_instance" "test" {
  ami                         = data.aws_ami.ami.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet[each.value.subnet_no].id
  key_name                    = "mumbai"
  vpc_security_group_ids      = [aws_security_group.sg_1.id]
  availability_zone           = "ap-south-1${each.value.az}"
  associate_public_ip_address = each.value.public_ip
  user_data                   = file("data.sh")
  for_each                    = { for data in var.instance : data.name => data }
  tags = {
    Name = "${each.value.name}"
  }
}