# Instance
resource "aws_security_group" "myinstance" {
    # vpc_id      = aws_vpc.main.id
    # vpc_id = module.vpc.vpc_id
    vpc_id = var.VPC_ID
    name        = "myinstance"
    description = "security group for my instance"

    # Ingress
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Egress
    egress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }

    # Enable ICMP
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "myinstance"
    }
}

# Load Balancers
resource "aws_security_group" "elb-securitygroup" {
    # vpc_id      = aws_vpc.main.id
    # vpc_id = module.vpc.vpc_id
    vpc_id = var.VPC_ID
    name        = "elb"
    description = "security group for load balancer"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "elb"
    }
}

# DATABASE POSTGRESQL
resource "aws_security_group" "db-securitygroup" {
    vpc_id = var.VPC_ID
    name        = "postgresql-dev"
    description = "security group for database"

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        security_groups = [aws_security_group.myinstance.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Owner       = "user"
        Environment = "dev"
    }
}
