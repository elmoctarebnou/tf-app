variable "region" {
  default = "us-west-2"
}

variable "ecs-service-name" {}
variable "ecs-cluster-id" {}
variable "ecs-tg-arn" {
  
}
variable "docker-image-url" {}
variable "memory" {}
variable "docker-container-port" {}
variable "desired-task-number" {}
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
variable "ecs-tg-name" {
  
}
