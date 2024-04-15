// Public ecurity group for the VPC
resource "aws_security_group" "public-security-group" {
    name       = "${var.environment-name}-public-security-group"
    description = "Allow all inbound traffic"
    vpc_id = aws_vpc.main-vpc.id

    tags = {
        Name = "${var.environment-name}-public-security-group"
    }
}
// Public security group rules
resource "aws_security_group_rule" "public_out" {
    type             = "egress"
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-security-group.id
}
resource "aws_security_group_rule" "public_in" {
    type             = "ingress"
    from_port        = 80
    protocol         = "tcp"
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.public-security-group.id
}

// Private security group for the VPC
resource "aws_security_group" "private-security-group" {
    name       = "${var.environment-name}-private-security-group"
    description = "Allow all inbound traffic"
    vpc_id = aws_vpc.main-vpc.id

    tags = {
        Name = "${var.environment-name}-private-security-group"
    }
}
// Private security group rules
resource "aws_security_group_rule" "private_out" {
    type             = "egress"
    from_port        = 0
    protocol         = "-1"
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private-security-group.id
}
// Allow all inbound traffic from the VPC
resource "aws_security_group_rule" "private_in" {
    type             = "ingress"
    from_port        = 0
    protocol         = "-1"
    to_port          = 65535
    cidr_blocks      = [aws_vpc.main-vpc.cidr_block]
    security_group_id = aws_security_group.private-security-group.id
}