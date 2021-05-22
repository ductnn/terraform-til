locals {
    name = "postgresql-${var.ENV}"
    region = var.AWS_REGION
    tags = {
        Owner       = "user"
        Environment = var.ENV
    }
}

module "db" {
    source  = "terraform-aws-modules/rds/aws"
    identifier = local.name

    engine               = "postgres"
    engine_version       = "11.10"
    family               = "postgres11" # DB parameter group
    major_engine_version = "11"         # DB option group
    instance_class       = "db.t2.micro"

    allocated_storage     = 5

    name     = var.POSTGRES_NAME
    username = var.POSTGRES_USERNAME
    password = var.POSTGRES_PASSWORD
    port     = var.POSTGRES_PORT

    multi_az               = true
    # subnet_ids             = module.vpc.private_subnets
    subnet_ids = var.PRIVATE_SUBNETS
    # vpc_security_group_ids = [module.security_group.this_security_group_id]
    vpc_security_group_ids = [var.DB_SECURITY_GROUP]

    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_window      = "03:00-06:00"

    backup_retention_period = 0

    tags = local.tags
}
