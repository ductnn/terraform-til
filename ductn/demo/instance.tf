# resource "aws_instance" "django-app-1" {
#     ami           = var.AMIS[var.AWS_REGION]
#     instance_type = var.INSTANCE_TYPE

#     # the VPC subnet
#     subnet_id = aws_subnet.public-1.id

#     # the security group
#     vpc_security_group_ids = [aws_security_group.myinstance.id]

#     associate_public_ip_address = true

#     # the public SSH key
#     key_name = aws_key_pair.mykey.key_name

#     user_data = "${file(var.INSTALL_NGINX)}"
# }

resource "aws_launch_configuration" "launchconfig" {
    name_prefix     = "launchconfig"
    image_id        = var.AMIS[var.AWS_REGION]
    instance_type   = var.INSTANCE_TYPE
    key_name        = aws_key_pair.mykey.key_name
    security_groups = [aws_security_group.myinstance.id]
    user_data = "${file(var.INSTALL_NGINX)}"
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "autoscaling" {
    name                      = "autoscaling"
    # vpc_zone_identifier       = [
    #     aws_subnet.public-1.id,
    #     aws_subnet.public-2.id
    # ]
    vpc_zone_identifier = module.vpc.public_subnets
    launch_configuration      = aws_launch_configuration.launchconfig.name
    min_size                  = 2
    max_size                  = 2
    health_check_grace_period = 300
    health_check_type         = "ELB"
    load_balancers            = [aws_elb.my-elb.name]
    force_delete              = true

    tag {
        key                 = "Name"
        value               = "ec2 instance"
        propagate_at_launch = true
    }
}
