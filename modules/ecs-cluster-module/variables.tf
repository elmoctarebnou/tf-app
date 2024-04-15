variable "region" {
  description = "The AWS region to deploy the ECS cluster"
  type        = string
  default     = "us-west-2"
}

variable "environment-name" {
  description = "The environment name"
  type        = string
  default     = "dev"
}

variable "cluster-name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "ecs-fargate-cluster"
}

variable "subnets" {
  description = "The subnets to deploy the ECS cluster"
  type        = list(string)
}

variable "security-group" {
  description = "The security group to deploy the ECS cluster"
  type        = string
}

variable "vpc-id" {
  description = "The VPC ID to deploy the ECS cluster"
  type        = string
}

variable "container-name" {
  description = "The name of the container"
  type        = string
  default     = "api"
}

variable "container-port" {
  description = "The port of the container"
  type        = number
  default     = 80
}

variable "container-image" {
  description = "The image of the container"
  type        = string
}