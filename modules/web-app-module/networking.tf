/********/
// VPC //
/******/
data "aws_vpc" "default-vpc" {
    default = true
}
/************/
// Subnets //
/************/
data "aws_subnet_ids" "default-subnet" {
    vpc_id = data.aws_vpc.default-vpc.id
}
resource "aws_security_group" "instances" {
    name = "${var.app-name}-${var.environment-name}-instance-security-group"
}
resource "aws_security_group_rule" "allow_http_inbound" {
    type              = "ingress"
    security_group_id = aws_security_group.instances.id

    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.load-balancer.arn

    port = 80

    protocol = "HTTP"

    # By default, return a simple 404 page
    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "404: page not found"
            status_code  = 404
        }
    }
}

resource "aws_lb_target_group" "instances" {
    name     = "${var.app-name}-${var.environment-name}-tg"
    port     = 8080
    protocol = "HTTP"
    vpc_id   = data.aws_vpc.default-vpc.id

    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200"
        interval            = 15
        timeout             = 3
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_target_group_attachment" "instance-1" {
    target_group_arn = aws_lb_target_group.instances.arn
    target_id        = aws_instance.instance-1.id
    port             = 8080
}

resource "aws_lb_target_group_attachment" "instance-2" {
    target_group_arn = aws_lb_target_group.instances.arn
    target_id        = aws_instance.instance-2.id
    port             = 8080
}

resource "aws_lb_listener_rule" "instances" {
    listener_arn = aws_lb_listener.http.arn
    priority     = 100

    condition {
        path_pattern {
        values = ["*"]
        }
    }

    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.instances.arn
    }
}


resource "aws_security_group" "alb" {
    name = "${var.app-name}-${var.environment-name}-alb-security-group"
}

resource "aws_security_group_rule" "allow-alb-http-inbound" {
    type              = "ingress"
    security_group_id = aws_security_group.alb.id

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

}

resource "aws_security_group_rule" "allow-alb-all-outbound" {
    type              = "egress"
    security_group_id = aws_security_group.alb.id

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

}


resource "aws_lb" "load-balancer" {
    name               = "${var.app-name}-${var.environment-name}-web-app-lb"
    load_balancer_type = "application"
    subnets            = data.aws_subnet_ids.default-subnet.ids
    security_groups    = [aws_security_group.alb.id]
}