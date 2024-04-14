resource "aws_instance" "instance-1" {
    ami             = var.ami
    instance_type   = var.instance-type
    security_groups = [aws_security_group.instances.name]
    user_data       = <<-EOF
                #!/bin/bash
                echo "Hello, Server 1" > index.html
                python3 -m http.server 8080 &
                EOF
    tags = {
        Name = "${var.app-name}-${var.environment-name}-server-1"
    }
}

resource "aws_instance" "instance-2" {
    ami             = var.ami
    instance_type   = var.instance-type
    security_groups = [aws_security_group.instances.name]
    user_data       = <<-EOF
                #!/bin/bash
                echo "Hello, Server 2" > index.html
                python3 -m http.server 8080 &
                EOF
    tags = {
        Name = "${var.app-name}-${var.environment-name}-server-2"
    }
}