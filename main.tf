terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "bastion" {
  source = "./bastion"

  # vpc_id      =  module.aws_vpc.main.id
}

module "vpc" {
  source = "./vpc"

}
module "iam" {
  source = "./iam"
}
module "dynamodb" {
  source = "./dynamodb"

}