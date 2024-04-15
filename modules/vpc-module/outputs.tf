output "vpc-id" {
    value = aws_vpc.main-vpc.id
}

output "vpc-cidr-block" {
    value = aws_vpc.main-vpc.cidr_block
}

output "public-subnet-1-id" {
    value = aws_subnet.public-subnet-1.id
}

output "public-subnet-2-id" {
    value = aws_subnet.public-subnet-2.id
}

output "private-subnet-1-id" {
    value = aws_subnet.private-subnet-1.id
}

output "private-subnet-2-id" {
    value = aws_subnet.private-subnet-2.id
}

output "security-group-public-id" {
    value = aws_security_group.public-security-group.id
}

output "security-group-private-id" {
    value = aws_security_group.private-security-group.id
}