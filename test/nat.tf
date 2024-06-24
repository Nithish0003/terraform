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
  subnet_id     = aws_subnet.vpc2_subnet["vpc2-subnet-2"].id
  tags = {
    Name = "test-nat"
  }
}
# attaching nat gateway to route table
resource "aws_route_table" "rt_4" {
  vpc_id = aws_vpc.vpc_2.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.test-nat.id
  }
  tags = {
    Name = "rt-4"
  }
}
# associating private subnet for nat
resource "aws_route_table_association" "association-4" {
  subnet_id      = aws_subnet.vpc2_subnet["vpc2-subnet-1"].id
  route_table_id = aws_route_table.rt_4.id
}