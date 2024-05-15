provider "aws" {
  region     = "ap-south-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name="subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name="subnet-2"
  }
}

resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name="igw-1"
  }
}

resource "aws_default_route_table" "rt_1" {
  default_route_table_id = aws_vpc.test_vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_1.id
  }
  tags = {
    Name = "rt-1"
  }
}

resource "aws_route_table_association" "association-1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_vpc.test_vpc.default_route_table_id
}
