# creating subnets
resource "aws_subnet" "subnet" {
  for_each                = { for data in var.subnet_map : data.name => data }
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = each.value.public_ip
  availability_zone       = "ap-south-1${each.value.az}"
  tags = {
    Name = each.value.name
  }
}