module "vpc" {
    source     = "../modules/vpc"
    ENV        = "dev"
    AWS_REGION = var.AWS_REGION
}

module "security_groups" {
    source = "../modules/securitygroup"
    VPC_ID = module.vpc.vpc_id
}

module "load_balancer" {
    source = "../modules/loadbalancer"
    SECURITY_GROUP_ELB_ID = module.security_groups.elb_securitygroup_id
    PUBLIC_SUBNETS = module.vpc.public_subnets
}

module "instances" {
    source         = "../modules/instances"
    PUBLIC_SUBNETS = module.vpc.public_subnets
    SECURITY_GROUP_INSTANCE_ID = module.security_groups.myinstance_id
    ELB_NAME = module.load_balancer.elb_name
}

module "database" {
    source = "../modules/databases"
    ENV = "dev"
    AWS_REGION = var.AWS_REGION
    PRIVATE_SUBNETS = module.vpc.private_subnets
    DB_SECURITY_GROUP = module.security_groups.db_securitygroup_id
    POSTGRES_USERNAME = var.POSTGRES_USERNAME
    POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
}
