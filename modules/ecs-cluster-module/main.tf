provider "aws" {
    region = "${var.region}"
}
resource "aws_ecs_cluster" "ecs-fargate-cluster" {
    name = "${var.cluster-name}"
}

// ECS ALB
resource "aws_alb" "ecs-alb" {
    name               = "${var.cluster-name}-alb"
    internal           = false
    subnets            = var.subnets
    security_groups    = [var.security-group]
}


// Target group
resource "aws_alb_target_group" "ecs-tg" {
    name     = "${var.cluster-name}-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc-id
    target_type = "ip"
    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200"
        interval            = "60"
        timeout             = "30"
        unhealthy_threshold = "3"
        healthy_threshold   = "3"
    }

    tags = {
        Name = "${var.cluster-name}-tg"
    }
}

// Listener
resource "aws_alb_listener" "ecs-alb-http-listener" {
    load_balancer_arn = aws_alb.ecs-alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_alb_target_group.ecs-tg.arn
    }
    depends_on = [ aws_alb_target_group.ecs-tg ]
}

// ECS IAM role
resource "aws_iam_role" "ecs-role" {
    name = "${var.cluster-name}-iam-role"
    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ecs.amazonaws.com",
                    "ec2.amazonaws.com",
                    "application-autoscaling.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

// ECS IAM policy
resource "aws_iam_policy" "ecs-policy" {
    name        = "${var.cluster-name}-iam-policy"
    description = "ECS policy"
    policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:*",
                "ecr:*",
                "elasticloadbalancing:*",
                "elasticfilesystem:*",
                "cloudwatch:*",
                "logs:*",
                "s3:*",
                "sns:*",
                "sqs:*",
                "ec2:*",
                "iam:*",
                "autoscaling:*",
                "application-autoscaling:*",
                "rds:*",
                "dynamodb:*",
                "kms:*",
                "secretsmanager:*",
                "ssm:*",
                "tag:GetResources",
                "tag:GetTagKeys",
                "tag:GetTagValues"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

// ECS IAM role policy attachment
resource "aws_iam_role_policy_attachment" "ecs-policy-attachment" {
    role       = aws_iam_role.ecs-role.name
    policy_arn = aws_iam_policy.ecs-policy.arn
}


