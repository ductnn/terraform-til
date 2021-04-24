module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    name = "vpc-ductn"
    cidr = "10.0.0.0/16"
    azs = [
        "${var.AWS_REGION}a",
        "${var.AWS_REGION}b",
        "${var.AWS_REGION}c"
    ]

    # Subnets
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets  = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
    # Database Subnets
    # Cache Subnets

    enable_nat_gateway = false
    enable_vpn_gateway = false

    tags = {
        Terraform = "true"
        Environment = "test"
    }
}

