resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.vpc_1.id
  tags = {
    Name = "igw-1"
  }
}

resource "aws_internet_gateway" "igw_2" {
  vpc_id = aws_vpc.rds_vpc.id
  tags = {
    Name = "igw-2"
  }
}

resource "aws_internet_gateway" "igw_3" {
  vpc_id = aws_vpc.vpc_2.id
  tags = {
    Name = "igw-3"
  }
}