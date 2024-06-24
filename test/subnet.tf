resource "aws_subnet" "vpc1_subnet" {
  for_each                = { for data in var.vpc1_subnet : data.name => data }
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = each.value.public_ip
  availability_zone       = "ap-south-1${each.value.az}"
  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "rds_vpc_subnet" {
  for_each                = { for data in var.rds_vpc_subnet : data.name => data }
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = each.value.public_ip
  availability_zone       = "ap-south-1${each.value.az}"
  tags = {
    Name = each.value.name
  }
}

resource "aws_subnet" "vpc2_subnet" {
  for_each                = { for data in var.vpc2_subnet : data.name => data }
  vpc_id                  = aws_vpc.vpc_2.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = each.value.public_ip
  availability_zone       = "ap-south-1${each.value.az}"
  tags = {
    Name = each.value.name
  }
}
