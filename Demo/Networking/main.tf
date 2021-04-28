#----Create VPC------#
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "main"
    }
}

#----Create Subnet----#
resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_cidr_1
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"
    tags = {
        Name = "public_subnet_1"
    }
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_cidr_2
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = "true"
    tags = {
        Name = "public_subnet_2"
    }
}

#-----Create Internet Gateway-------#
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = " Internet Gateway"
    }
}

#-----Create Route Table----------#
resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route-table"
  }
}

#------Associate subnet with Route Table--------#
resource "aws_route_table_association" "route-prod-1" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_route_table_association" "route-prod-2" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.route-table.id
}

#-----Create Security group-------#
resource "aws_security_group" "allow_web_traffic" {
  name = "allow_web_traffic"
  vpc_id = aws_vpc.main.id
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow_web"
  }
}
