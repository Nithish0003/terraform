# allocating elastic ip
resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  tags = {
    Name = "test-eip"
  }
}
# creating NAT Gateway
resource "aws_nat_gateway" "test-nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.subnet["subnet-1"].id
  tags = {
    Name = "test-nat"
  }
}
# attaching nat gateway to route table
resource "aws_route_table" "rt_2" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.test-nat.id
  }
  tags = {
    Name = "rt-2"
  }
}
# associating private subnet for nat
resource "aws_route_table_association" "association-2" {
  subnet_id      = aws_subnet.subnet["subnet-3"].id
  route_table_id = aws_route_table.rt_2.id
}