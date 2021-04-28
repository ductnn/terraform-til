module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "vpc-${var.ENV}"
    cidr = "10.0.0.0/16"

    azs = [
        "${var.AWS_REGION}a",
        "${var.AWS_REGION}b",
        "${var.AWS_REGION}c"
    ]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = false

    tags = {
        Terraform   = "true"
        Environment = var.ENV
    }
}
