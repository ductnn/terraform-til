output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet_1" {
    value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
    value = aws_subnet.public_subnet_2.id
}

output "allow_web_traffic" {
    value = aws_security_group.allow_web_traffic.id
}