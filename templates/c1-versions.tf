# Specifies the required Terraform version and providers
terraform {
  required_version = "~>1.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.95"
    }
    # Null provider for managing null resources
    null = {
      source  = "hashicorp/null"
      version = "~>3.2"
    }
    # Random provider for generating random values
    random = {
      source  = "hashicorp/random"
      version = "~>3.7"
    }
  }
  # Configures the backend for remote state storage
  backend "s3" {
  }
}

# Defines provider configurations for AWS, Null, and Random
# Defining AWS provider block with default region and tags
provider "aws" {
  region = "us-east-1"
}

# Defining Null provider block to manage null resources
provider "null" {
}

# Generates a random pet name
# Resource block to generate a random pet name
resource "random_pet" "this" {
  length = 2
}

