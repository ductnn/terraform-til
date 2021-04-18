# Instance
resource "aws_security_group" "myinstance" {
    vpc_id      = aws_vpc.main.id
    name        = "myinstance"
    description = "security group for my instance"
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ingress {
    #     from_port   = 22
    #     to_port     = 22
    #     protocol    = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    # ingress {
    #     from_port       = 80
    #     to_port         = 80
    #     protocol        = "tcp"
    #     security_groups = [aws_security_group.load_balancer.id]
    # }

    tags = {
        Name = "myinstance"
    }
}

# Load Balancers
resource "aws_security_group" "load_balancer" {
    name        = "load_balancer_security_group"
    description = "Load Balancer Security Group"
    vpc_id = aws_vpc.main.id
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

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "LoadBalancer"
    }
}
