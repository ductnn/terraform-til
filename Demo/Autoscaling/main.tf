#----Create Launch Template---------#
resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-013f17f36f8b1fefb"
  instance_type = "t2.micro"
  key_name = "test"
  vpc_security_group_ids = [var.allow_web_traffic]
}

#-----Create Autoscaling Group------#
resource "aws_autoscaling_group" "bar" {
  vpc_zone_identifier = [var.public_subnet_1,var.public_subnet_2]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}

#--------Attach Autoscaling Group to Target Group--------#
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.bar.id
  alb_target_group_arn   = var.alb_target_group_arn
}
