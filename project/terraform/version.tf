# Terraform AWS provider version. Make sure terraform version (used in github workflow) and provider version are compatible.
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
    template = {
      source = "hashicorp/template"
    }
  }
}