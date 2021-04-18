# VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"

    tags = {
        Name = "main"
    }
}

# Subnets
resource "aws_subnet" "public-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1a"
    tags = {
        Name = "public-1"
    }
}

resource "aws_subnet" "public-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-east-1b"
    tags = {
        Name = "public-2"
    }
}

# resource "aws_subnet" "private-1" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.3.0/24"
#     map_private_ip_on_launch = "true"
#     availability_zone       = "us-east-1"
#     tags = {
#         Name = "private-1"
#     }
# }

# resource "aws_subnet" "private-2" {
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.4.0/24"
#     map_private_ip_on_launch = "true"
#     availability_zone       = "us-east-1"
#     tags = {
#         Name = "private-2"
#     }
# }

# Internet Gateway
resource "aws_internet_gateway" "gateway"{
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main"
    }
}

# Route tables
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }

    tags = {
        Name = "public-1"
    }
}

# resource "aws_route_table" "private" {
#     vpc_id = aws_vpc.main.id
#     route {
#         cidr_block     = "0.0.0.0/0"
#         nat_gateway_id = aws_nat_gateway.nat-gw.id
#     }

#     tags = {
#         Name = "private-1"
#     }
# }

# Route tables association
resource "aws_route_table_association" "public-1" {
    subnet_id      = aws_subnet.public-1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-2" {
    subnet_id      = aws_subnet.public-2.id
    route_table_id = aws_route_table.public.id
}

# resource "aws_route_table_association" "private-1" {
#     subnet_id      = aws_subnet.private-1.id
#     route_table_id = aws_route_table.private.id
# }

# resource "aws_route_table_association" "private-2" {
#     subnet_id      = aws_subnet.private-2.id
#     route_table_id = aws_route_table.private.id
# }
