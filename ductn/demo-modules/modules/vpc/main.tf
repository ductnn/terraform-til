module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "vpc-${var.ENV}"
    cidr = "10.0.0.0/16"

    azs = [
        "${var.AWS_REGION}a",
        "${var.AWS_REGION}b"
    ]
    private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
    public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = false

    tags = {
        Terraform   = "true"
        Environment = var.ENV
    }
}

# Route tables for the subnets
resource "aws_route_table" "public-route-table" {
    vpc_id = module.vpc.vpc_id
}
resource "aws_route_table" "private-route-table" {
    vpc_id = module.vpc.vpc_id
}

# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "public-route-1-association" {
    route_table_id = aws_route_table.public-route-table.id
    subnet_id      = module.vpc.public_subnets[0]
}
resource "aws_route_table_association" "public-route-2-association" {
    route_table_id = aws_route_table.public-route-table.id
    subnet_id      = module.vpc.public_subnets[1]
}
resource "aws_route_table_association" "private-route-1-association" {
    route_table_id = aws_route_table.private-route-table.id
    subnet_id      = module.vpc.private_subnets[0]
}
resource "aws_route_table_association" "private-route-2-association" {
    route_table_id = aws_route_table.private-route-table.id
    subnet_id      = module.vpc.private_subnets[1]
}

# Elastic IP
resource "aws_eip" "elastic-ip-for-nat-gw" {
    vpc = true
    depends_on = [aws_internet_gateway.production-igw]
}

# NAT gateway
resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.elastic-ip-for-nat-gw.id
    subnet_id     = module.vpc.public_subnets[0]
    depends_on    = [aws_eip.elastic-ip-for-nat-gw]
}
resource "aws_route" "nat-gw-route" {
    route_table_id         = aws_route_table.private-route-table.id
    nat_gateway_id         = aws_nat_gateway.nat-gw.id
    destination_cidr_block = "0.0.0.0/0"
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "production-igw" {
    vpc_id = module.vpc.vpc_id
}

# Route the public subnet traffic through the Internet Gateway
resource "aws_route" "public-internet-igw-route" {
    route_table_id         = aws_route_table.public-route-table.id
    gateway_id             = aws_internet_gateway.production-igw.id
    destination_cidr_block = "0.0.0.0/0"
}
