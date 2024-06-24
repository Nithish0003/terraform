variable "vpc1_subnet" {
    type = list(object({
    name = string, cidr = string, az = string, public_ip = bool}))
    default = [
    { "name" = "vpc1-subnet-1", "cidr" = "192.168.1.0/28", "az" = "a", "public_ip" = true },
    { "name" = "vpc1-subnet-2", "cidr" = "192.168.1.16/28", "az" = "b", "public_ip" = true }]
}

variable "rds_vpc_subnet" {
    type = list(object({
    name = string, cidr = string, az = string, public_ip = bool}))
    default = [
    { "name" = "rds-vpc-subnet-1", "cidr" = "192.168.2.0/28", "az" = "a", "public_ip" = true },
    { "name" = "rds-vpc-subnet-2", "cidr" = "192.168.2.16/28", "az" = "b", "public_ip" = false }]
}

variable "vpc2_subnet" {
    type = list(object({
    name = string, cidr = string, az = string, public_ip = bool}))
    default = [
    { "name" = "vpc2-subnet-1", "cidr" = "192.168.3.0/28", "az" = "a", "public_ip" = false },
    { "name" = "vpc2-subnet-2", "cidr" = "192.168.3.16/28", "az" = "b", "public_ip" = true }]
}

variable "key_pair" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDW8EjxDWloSO+cBUBLwNw1C0NaKbSlh+QclxpIU02YgLNssRENy6JpUhdCQrWRx0STIoQdM8PuQ8DXBwmTXqJ0VVlWPqFAceJfzUUBac2s000aLyQjxNf/R96wG/+nauZuQZVi0zjnQ0VqP6Pvn26jFmixgETAZjCZqlMLV5zIJE4Zsi+LkWPpJkNj2e5YZ1hDWy4AHqMrPTdytrvrbWPBKppZi+LDBTf9BiluwaguOW+LhJCXSwufkW+jld40GUNdL5334USasAhGtg4jDqTU/Mzc1HP8exwT1/Leeulp6dp3GJcTNqxmSnpqxJd/QC943rMcmn9PIH8QB2dYUQNX07pBAw4PFWnJ6Kdf8NZbQ/hCb8ab/XeNKiyQMPp4VV7vP/ovsN7DtSQQu4X2c7Tx59XX+ra0v2CPSuW+N47uGSjrWn5Pxs6n3aHozWAbhfxMgG3PfsJ9pW5w5e2oErDK76bTfNBt8rdLb78K0rFa5ENp0YfC8iZlGFEg49Tn4d8= nits0@nithish"
}

variable "vpc1_instance" {
    type = list(object({ name = string, subnet_no = string, az = string, public_ip = bool }))
    default = [
    { "name" = "vpc1-test-1", "az" = "a", "subnet_no" = "vpc1-subnet-1", public_ip = true },
    { "name" = "vpc1-test-2", "az" = "b", "subnet_no" = "vpc1-subnet-2", public_ip = true }]
}

variable "rds_vpc_instance" {
    type = list(object({ name = string, subnet_no = string, az = string, public_ip = bool }))
    default = [
    { "name" = "rds-vpc-test-1", "az" = "a", "subnet_no" = "rds-vpc-subnet-1", public_ip = true }]
}

variable "vpc2_instance" {
    type = list(object({ name = string, subnet_no = string, az = string, public_ip = bool }))
    default = [
    { "name" = "vpc2-test-1", "az" = "a", "subnet_no" = "vpc2-subnet-1", public_ip = false },
    { "name" = "vpc2-test-2", "az" = "b", "subnet_no" = "vpc2-subnet-2", public_ip = true }]
}