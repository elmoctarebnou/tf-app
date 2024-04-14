terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

// Create the VPC
resource "aws_vpc" "main-vpc" {
    cidr_block = var.vpc-cidr
    enable_dns_hostnames = true
    tags = {
        Name = "${var.environment-name}-main-vpc"
    }
}

// Create the public and private subnets
resource "aws_subnet" "public-subnet-1" {
    vpc_id     = aws_vpc.main-vpc.id
    cidr_block = var.public-subnet-1-cidr
    availability_zone = "us-west-2a"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.environment-name}-public-subnet-1"
    }
}

resource "aws_subnet" "public-subnet-2" {
    vpc_id     = aws_vpc.main-vpc.id
    cidr_block = var.public-subnet-2-cidr
    availability_zone = "us-west-2b"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.environment-name}-public-subnet-2"
    }
}

resource "aws_subnet" "private-subnet-1" {
    vpc_id     = aws_vpc.main-vpc.id
    cidr_block = var.private-subnet-1-cidr
    availability_zone = "us-west-2a"
    tags = {
        Name = "${var.environment-name}-private-subnet-1"
    }
}

resource "aws_subnet" "private-subnet-2" {
    vpc_id     = aws_vpc.main-vpc.id
    cidr_block = var.private-subnet-2-cidr
    availability_zone = "us-west-2b"
    tags = {
        Name = "${var.environment-name}-private-subnet-2"
    }
}

resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.main-vpc.id
    tags = {
        Name = "${var.environment-name}-public-route-table"
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.main-vpc.id
    tags = {
        Name = "${var.environment-name}-private-route-table"
    }
}

// Associate the route tables with the subnets
resource "aws_route_table_association" "public-subnet-1-association" {
    subnet_id      = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-association" {
    subnet_id      = aws_subnet.public-subnet-2.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-subnet-1-association" {
    subnet_id      = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-subnet-2-association" {
    subnet_id      = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.private-route-table.id
}

// Create Elastic IPs for the NAT gateways
resource "aws_eip" "nat-eip" {
    vpc                       = true  
    associate_with_private_ip = "10.0.0.5"

    tags = {
        "Name" = "${var.environment-name}-nat-eip"
    }
}

// Create the NAT gateways to allow the private subnets to access the internet
resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id     = aws_subnet.public-subnet-1.id
    tags = {
        Name = "${var.environment-name}-nat-gateway"
    }

    depends_on = [aws_internet_gateway.main-igw]
}

// NAT gateway route. This route will allow the private subnets to access the internet
resource "aws_route" "nat-gateway-route" {
    route_table_id         = aws_route_table.private-route-table.id
    nat_gateway_id         = aws_nat_gateway.nat-gateway.id
    destination_cidr_block = "0.0.0.0/0"
}

// Create the internet gateway
resource "aws_internet_gateway" "main-igw" {
    vpc_id = aws_vpc.main-vpc.id
    tags = {
        Name = "${var.environment-name}-main-igw"
    }
}

// Route table for the public subnets
resource "aws_route" "public-route" {
    route_table_id         = aws_route_table.public-route-table.id
    gateway_id             = aws_internet_gateway.main-igw.id
    destination_cidr_block = "0.0.0.0/0"
}