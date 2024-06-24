# attaching igw to route tabble
resource "aws_route_table" "rt_1" {
  vpc_id = aws_vpc.vpc_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_1.id
  }
  tags = {
    Name = "rt-1"
  }
}

resource "aws_route_table" "rt_2" {
  vpc_id = aws_vpc.rds_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_2.id
  }
  tags = {
    Name = "rt-2"
  }
}

resource "aws_route_table" "rt_3" {
  vpc_id = aws_vpc.vpc_2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_3.id
  }
  tags = {
    Name = "rt-3"
  }
}

# associate subnets
resource "aws_route_table_association" "association-1" {
  count = 2
  subnet_id      = aws_subnet.vpc1_subnet["vpc1-subnet-${count.index + 1}"].id
  route_table_id = aws_route_table.rt_1.id
}

resource "aws_route_table_association" "association-2" {
  subnet_id      = aws_subnet.rds_vpc_subnet["rds-vpc-subnet-1"].id
  route_table_id = aws_route_table.rt_2.id
}

resource "aws_route_table_association" "association-3" {
  subnet_id      = aws_subnet.vpc2_subnet["vpc2-subnet-2"].id
  route_table_id = aws_route_table.rt_3.id
}