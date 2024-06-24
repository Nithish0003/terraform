resource "aws_vpc_peering_connection" "vpc1_vpc2" {
  # accepter
  peer_vpc_id = aws_vpc.vpc_2.id
  # requestor
  vpc_id = aws_vpc.vpc_1.id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name="vpc1-vpc2"
  }
}

resource "aws_vpc_peering_connection" "rds_vpc-vpc2" {
  # accepter
  peer_vpc_id = aws_vpc.rds_vpc.id
  # requestor
  vpc_id = aws_vpc.vpc_1.id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = {
    Name="rds_vpc-vpc2"
  }
}

resource "aws_route_table" "rt_5" {
  vpc_id = aws_vpc.vpc_1.id
  tags = {
    Name="rt-5"
  }
}

resource "aws_route" "route_1" {
  route_table_id            = aws_route_table.rt_5.id
  destination_cidr_block    = aws_vpc.vpc_2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route_table" "rt_6" {
  vpc_id = aws_vpc.vpc_2.id
  tags = {
    Name="rt-6"
  }
}

resource "aws_route" "route_2" {
  route_table_id            = aws_route_table.rt_6.id
  destination_cidr_block    = aws_vpc.vpc_1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_vpc2.id
}

resource "aws_route_table" "rt_7" {
  vpc_id = aws_vpc.rds_vpc.id
  tags = {
    Name="rt-7"
  }
}

resource "aws_route" "route_3" {
  route_table_id            = aws_route_table.rt_7.id
  destination_cidr_block    = aws_vpc.vpc_2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.rds_vpc-vpc2.id
}

# resource "aws_route_table" "rt_8" {
#   vpc_id = aws_vpc.vpc_2.id
#   tags = {
#     Name="rt-8"
#   }
# }

# resource "aws_route" "route_4" {
#   route_table_id            = aws_route_table.rt_8.id
#   destination_cidr_block    = aws_vpc.rds_vpc.cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.rds_vpc-vpc2.id
# }