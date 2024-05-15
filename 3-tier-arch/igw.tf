# creating internet gateway and attach to vpc
resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "igw-1"
  }
}