#Defining VPC variables.

variable "vpc_name" {
  default     = "vpc"
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "value of CIDR for VPC"
}

variable "azs" {
  description = "value of availability zones to deploy resources"
}

variable "vpc_enable_nat_gateway" {
  default     = true
  description = "value to enable NAT Gateway"
}

variable "vpc_single_nat_gateway" {
  default     = true
  description = "value to create single NAT Gateway"
}
