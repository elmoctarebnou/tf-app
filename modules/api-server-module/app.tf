# Nginx task definition
resource "aws_ecs_task_definition" "nginx-task-definition" {
    family                   = var.ecs-service-name
    network_mode             = "awsvpc"
    cpu                      = 256
    memory                   = 512
    requires_compatibilities = ["FARGATE"]

    container_definitions = jsonencode([
        {
            name      = var.ecs-service-name
            image     = var.docker-image-url
            cpu       = 256
            memory    = 512
            essential = true
            portMappings = [
                {
                    containerPort = var.docker-container-port
                    hostPort      = var.docker-container-port
                    protocol      = "tcp"
                }
            ]
        }
    ])
}


// Nginx service
resource "aws_ecs_service" "nginx-service" {
    name            = var.ecs-service-name
    task_definition = var.ecs-service-name
    desired_count   = 2
    cluster         = var.ecs-cluster-id
    launch_type     = "FARGATE"

    network_configuration {
        subnets            = var.subnets
        security_groups    = [var.security-group]
        assign_public_ip  = true
    }

    load_balancer {
        container_name   = var.ecs-service-name
        container_port   = var.docker-container-port
        target_group_arn = var.ecs-tg-arn
    }
}
