
#Generic variables used in the project
variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "environment" {
  description = "value of environment to deploy resources"
}

variable "department" {
  description = "Department for tagging resources"
  default     = "tech"
}
