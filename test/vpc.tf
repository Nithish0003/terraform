provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "vpc_1" {
  cidr_block       = "192.168.1.0/24"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpc-1"
  }
}

resource "aws_vpc" "rds_vpc" {
  cidr_block       = "192.168.2.0/24"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "rds-vpc"
  }
}

resource "aws_vpc" "vpc_2" {
  cidr_block       = "192.168.3.0/24"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpc-2"
  }
}