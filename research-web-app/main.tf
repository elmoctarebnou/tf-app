/****************************/
// Terraform configuration //
/****************************/
terraform {
  # backend "s3" {
  #     bucket = "ebnou-terraform-state"
  #     key    = "tf-infra/terraform.tfstate"
  #     region = "us-west-2"
  #     dynamodb_table = "ebnou-terraform-state-lock"
  #     encrypt = true
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region  = "us-west-2"
  profile = "default"
}

module "web_app_1" {
  source           = "../web-app-module"
  app_name         = "web-app-1"
  environment_name = "research"
  instance_type    = "t2.micro"
}