#Defining VPC variables.

variable "vpc_name" {
  default = "vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
}

variable "vpc_create_database_subnet_route_table" {
  default = true
}

variable "vpc_enable_nat_gateway" {
  default = true
}

variable "vpc_single_nat_gateway" {
  default = true
}
