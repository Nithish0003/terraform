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
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "subnet-2"
  }
}

resource "aws_internet_gateway" "igw_1" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "igw-1"
  }
}

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

resource "aws_route_table_association" "association-1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.rt_1.id
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.4.20240429.0-kernel-6.1-x86_64"]
  }
  # filter {
  #   name   = "Vitualization-type"
  #   values = ["hvm"]
  # }
}

resource "aws_key_pair" "mumbai" {
  key_name   = "mumbai"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDW8EjxDWloSO+cBUBLwNw1C0NaKbSlh+QclxpIU02YgLNssRENy6JpUhdCQrWRx0STIoQdM8PuQ8DXBwmTXqJ0VVlWPqFAceJfzUUBac2s000aLyQjxNf/R96wG/+nauZuQZVi0zjnQ0VqP6Pvn26jFmixgETAZjCZqlMLV5zIJE4Zsi+LkWPpJkNj2e5YZ1hDWy4AHqMrPTdytrvrbWPBKppZi+LDBTf9BiluwaguOW+LhJCXSwufkW+jld40GUNdL5334USasAhGtg4jDqTU/Mzc1HP8exwT1/Leeulp6dp3GJcTNqxmSnpqxJd/QC943rMcmn9PIH8QB2dYUQNX07pBAw4PFWnJ6Kdf8NZbQ/hCb8ab/XeNKiyQMPp4VV7vP/ovsN7DtSQQu4X2c7Tx59XX+ra0v2CPSuW+N47uGSjrWn5Pxs6n3aHozWAbhfxMgG3PfsJ9pW5w5e2oErDK76bTfNBt8rdLb78K0rFa5ENp0YfC8iZlGFEg49Tn4d8= nits0@nithish"
}

resource "aws_security_group" "sg_1" {
  name   = "sg_1"
  vpc_id = aws_vpc.test_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]

  }
  tags = {
    Name = "sg_1"
  }
}

resource "aws_instance" "test_1" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_1.id
  key_name = "mumbai"
  vpc_security_group_ids = [ aws_security_group.sg_1.id ]
  availability_zone = "ap-south-1a"
  associate_public_ip_address = true
  tags = {
    Name="test-1"
  }
}

resource "aws_instance" "test_2" {
  ami = data.aws_ami.ami.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_2.id
  key_name = "mumbai"
  vpc_security_group_ids = [ aws_security_group.sg_1.id ]
  availability_zone = "ap-south-1b"
  associate_public_ip_address = false
  tags = {
    Name="test-2"
  }
}