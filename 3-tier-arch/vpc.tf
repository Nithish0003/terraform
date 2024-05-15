provider "aws" {
  region = "ap-south-1"
}
# creating vpc
resource "aws_vpc" "test_vpc" {
  cidr_block       = "192.168.14.0/24"
  instance_tenancy = "default"
  tags = {
    Name = "test-vpc"
  }
}