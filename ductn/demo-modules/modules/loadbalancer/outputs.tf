output "elb_name" {
    description = "The name of the ELB"
    value       = aws_elb.my-elb.name
}
