variable "subnet_map" {
    type = list(object({
    name = string, cidr = string, az = string, public_ip = bool}))
    default = [
    { "name" = "subnet-1", "cidr" = "192.168.14.0/28", "az" = "a", "public_ip" = true },
    { "name" = "subnet-2", "cidr" = "192.168.14.16/28", "az" = "b", "public_ip" = true },
    { "name" = "subnet-3", "cidr" = "192.168.14.32/28", "az" = "a", "public_ip" = false },
    { "name" = "subnet-4", "cidr" = "192.168.14.48/28", "az" = "b", "public_ip" = false },
    { "name" = "subnet-5", "cidr" = "192.168.14.64/28", "az" = "a", "public_ip" = false },
    { "name" = "subnet-6", "cidr" = "192.168.14.80/28", "az" = "b", "public_ip" = false }]
}
variable "key_pair" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDW8EjxDWloSO+cBUBLwNw1C0NaKbSlh+QclxpIU02YgLNssRENy6JpUhdCQrWRx0STIoQdM8PuQ8DXBwmTXqJ0VVlWPqFAceJfzUUBac2s000aLyQjxNf/R96wG/+nauZuQZVi0zjnQ0VqP6Pvn26jFmixgETAZjCZqlMLV5zIJE4Zsi+LkWPpJkNj2e5YZ1hDWy4AHqMrPTdytrvrbWPBKppZi+LDBTf9BiluwaguOW+LhJCXSwufkW+jld40GUNdL5334USasAhGtg4jDqTU/Mzc1HP8exwT1/Leeulp6dp3GJcTNqxmSnpqxJd/QC943rMcmn9PIH8QB2dYUQNX07pBAw4PFWnJ6Kdf8NZbQ/hCb8ab/XeNKiyQMPp4VV7vP/ovsN7DtSQQu4X2c7Tx59XX+ra0v2CPSuW+N47uGSjrWn5Pxs6n3aHozWAbhfxMgG3PfsJ9pW5w5e2oErDK76bTfNBt8rdLb78K0rFa5ENp0YfC8iZlGFEg49Tn4d8= nits0@nithish"
}
variable "instance" {
    type = list(object({ name = string, subnet_no = string, az = string, public_ip = bool }))
    default = [
    { "name" = "baston-host", "az" = "a", "subnet_no" = "subnet-1", public_ip = true },
    { "name" = "test-1", "az" = "a", "subnet_no" = "subnet-1", public_ip = true },
    { "name" = "test-2", "az" = "b", "subnet_no" = "subnet-2", public_ip = true },
    { "name" = "test-3", "az" = "a", "subnet_no" = "subnet-3", public_ip = false },
    { "name" = "test-4", "az" = "b", "subnet_no" = "subnet-4", public_ip = false }]
}
variable "template" {
    type = list(object({ name = string, public_ip = bool }))
    default = [
    { "name" = "template-1", public_ip = true },
    { "name" = "template-2", public_ip = false }]
}