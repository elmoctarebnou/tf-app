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

# module "web-app" {
#   source           = "../modules/web-app-module"
#   app-name         = "web-app"
#   environment-name = "dev"
#   instance-type    = "t2.micro"
# }

module "vpc" {
  source            = "../modules/vpc-module"
  region            = "us-west-2"
  environment-name  = "dev"
  vpc-cidr          = "10.0.0.0/16"
  public-subnet-1-cidr = "10.0.1.0/24"
  public-subnet-2-cidr = "10.0.2.0/24"
  private-subnet-1-cidr = "10.0.4.0/24"
  private-subnet-2-cidr = "10.0.5.0/24"
}  
