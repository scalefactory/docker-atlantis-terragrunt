provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = ">= 0.12, < 2.0"
  required_providers {
    aws = "~> 2.0"
    random = "~> 2.2"
    template = "~> 2.1"
  }
}
