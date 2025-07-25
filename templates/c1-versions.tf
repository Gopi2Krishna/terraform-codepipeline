
#defining terraform block

terraform {
  required_version = "~>1.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.95"
    }

    null = {
      source  = "hashicorp/null"
      version = "~>3.2"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.7"
    }
  }
}


#defining provider blocks
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = local.tags
  }
}

provider "null" {
}

resource "random_pet" "this" {
  length = 2
}
