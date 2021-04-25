# resource "aws_instance" "bastion" {
#     ami           = var.AMIS[var.AWS_REGION]
#     instance_type = var.INSTANCE_TYPE

#     # the VPC subnet
#     subnet_id = element(var.PUBLIC_SUBNETS, 0)

#     # the security group
#     # vpc_security_group_ids = [aws_security_group.myinstance.id]
#     vpc_security_group_ids = [var.SECURITY_GROUP_INSTANCE_ID]

#     associate_public_ip_address = true

#     # the public SSH key
#     key_name = aws_key_pair.mykey.key_name

#     user_data = "${file(var.INSTALL_SOFTWARE)}"
# }

resource "aws_launch_configuration" "launchconfig" {
    name_prefix     = "launchconfig"
    image_id        = var.AMIS[var.AWS_REGION]
    instance_type   = var.INSTANCE_TYPE
    key_name        = aws_key_pair.mykey.key_name
    # security_groups = [aws_security_group.myinstance.id]
    security_groups = [var.SECURITY_GROUP_INSTANCE_ID]
    user_data = "${file(var.INSTALL_SOFTWARE)}"
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "autoscaling" {
    name                      = "autoscaling"
    vpc_zone_identifier = var.PUBLIC_SUBNETS
    launch_configuration      = aws_launch_configuration.launchconfig.name
    min_size                  = 2
    max_size                  = 2
    health_check_grace_period = 300
    health_check_type         = "ELB"
    load_balancers            = [var.ELB_NAME]
    force_delete              = true

    tag {
        key                 = "Name"
        value               = "EC2 Instance"
        propagate_at_launch = true
    }
}

resource "aws_key_pair" "mykey" {
    key_name   = "mykey"
    public_key = file("${path.root}/${var.PATH_TO_PUBLIC_KEY}")
}
