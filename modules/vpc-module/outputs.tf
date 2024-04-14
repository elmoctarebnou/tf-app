output "vpc-id" {
    value = aws_vpc.main-vpc.id
}

output "vpc-cidr-block" {
    value = aws_vpc.main-vpc.cidr_block
}

output "public-subnet-1-id" {
    value = aws_subnet.public-subnet-1.id
}

output "public_subnet-2-id" {
    value = aws_subnet.public-subnet-2.id
}

output "private-subnet-1-id" {
    value = aws_subnet.private-subnet-1.id
}

output "private-subnet-2-id" {
    value = aws_subnet.private-subnet-2.id
}
