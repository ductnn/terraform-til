resource "aws_elb" "my-elb" {
    name            = "my-elb"
    # subnets         = [aws_subnet.public-1.id, aws_subnet.public-2.id]
    # subnets = module.vpc.public_subnets
    subnets = var.PUBLIC_SUBNETS
    # security_groups = [aws_security_group.elb-securitygroup.id]
    security_groups = [var.SECURITY_GROUP_ELB_ID]
    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }
    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:80/"
        interval            = 30
    }

    cross_zone_load_balancing   = true
    connection_draining         = true
    connection_draining_timeout = 400
    tags = {
        Name = "my-elb"
    }
}
