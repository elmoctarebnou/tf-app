variable "region" {
    description = "The AWS region to deploy the VPC"
    type        = string
    default     = "us-west-2"
}

variable "environment-name" {
    description = "The name of the environment (dev/test/prod)"
    type        = string
    default     = "dev"
}

variable "vpc-cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "public-subnet-1-cidr" {
    description = "Public subnet 1 CIDR block"
    type        = string
}

variable "public-subnet-2-cidr" {
    description = "Public subnet 2 CIDR block"
    type        = string
}

variable "private-subnet-1-cidr" {
    description = "Private subnet 1 CIDR block"
    type        = string
}

variable "private-subnet-2-cidr" {
    description = "Private subnet 2 CIDR block"
    type        = string
}

