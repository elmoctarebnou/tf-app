variable "region" {
    description = "The AWS region to launch the instance"
    type        = string
    default     = "us-west-2"
}
variable "environment_name" {
    description = "The name of the environment (dev/test/prod)"
    type        = string
    default     = "dev"
}
variable "app_name" {
    description = "The name of the application"
    type        = string
    default     = "web-app"
}
variable "instance_name" {
    description = "The name of the EC2 instance"
    type        = string
    default     = "ec2-server"
}
variable "ami" {
    description = "Amazon machine image to use for the EC2 instance"
    type        = string
    default     = "ami-005e54dee72cc1d00"
}
variable "instance_type" {
    description = "The type of EC2 instance to launch"
    type        = string
    default     = "t2.micro"
}

