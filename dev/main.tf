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

module "ecs-cluster" {
  source            = "../modules/ecs-cluster-module"
  region            = "us-west-2"
  environment-name  = "dev"
  cluster-name      = "unicorn-ecs-fargate-cluster"
  subnets           = [module.vpc.public-subnet-1-id, module.vpc.public-subnet-2-id]
  security-group    = module.vpc.security-group-public-id
  vpc-id            = module.vpc.vpc-id
}

module "s3" {
  source            = "../modules/s3-module"
  bucket_name       = "ebnou-terraform-state"
  bucket_versioning = true
}
