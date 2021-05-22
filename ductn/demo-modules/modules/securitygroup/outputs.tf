output "myinstance_id" {
    description = "The ID of the Instance"
    value       = aws_security_group.myinstance.id
}

output "elb_securitygroup_id" {
    description = "The ID of the ELB"
    value       = aws_security_group.elb-securitygroup.id
}

output "db_securitygroup_id" {
    description = "The ID of the DataBase"
    value       = aws_security_group.db-securitygroup.id
}
