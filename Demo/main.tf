provider "aws" {
    region = var.aws_resource
    access_key = var.AWS_Access_Key
    secret_key = var.AWS_Secret_Key
}

module "Networking" {
    source = "./Networking"
    vpc_cidr = "10.1.0.0/16"
    public_cidr_1 = "10.1.1.0/24"
    public_cidr_2 = "10.1.2.0/24"
}

module "Alb" {
    source = "./Alb"
    public_subnet_1 = module.Networking.public_subnet_1
    public_subnet_2 = module.Networking.public_subnet_2
    allow_web_traffic = module.Networking.allow_web_traffic
    vpc_id = module.Networking.vpc_id
}

module "Autoscaling" {
    source = "./Autoscaling"
    allow_web_traffic = module.Networking.allow_web_traffic
    alb_target_group_arn = module.Alb.alb_target_group_arn
    public_subnet_1 = module.Networking.public_subnet_1
    public_subnet_2 = module.Networking.public_subnet_2
}