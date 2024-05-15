# attaching igw to route tabble
resource "aws_route_table" "rt_1" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_1.id
  }
  tags = {
    Name = "rt-1"
  }
}
# associate subnets
resource "aws_route_table_association" "association-1" {
  count          = 2
  subnet_id      = aws_subnet.subnet["subnet-${count.index + 1}"].id
  route_table_id = aws_route_table.rt_1.id
}