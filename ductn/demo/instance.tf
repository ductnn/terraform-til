resource "aws_instance" "django-app-1" {
    ami           = var.AMIS[var.AWS_REGION]
    instance_type = var.INSTANCE_TYPE

    # the VPC subnet
    subnet_id = aws_subnet.public-1.id

    # the security group
    vpc_security_group_ids = [aws_security_group.myinstance.id]

    # the public SSH key
    key_name = aws_key_pair.mykey.key_name

    provisioner "file" {
        source      = "script.sh"
        destination = "/tmp/script.sh"
    }
    provisioner "remote-exec" {
        inline = [
        "chmod +x /tmp/script.sh",
        "sudo sed -i -e 's/\r$//' /tmp/script.sh", # Rm the spurious CR characters
        "sudo /tmp/script.sh",
        ]
    }
    connection {
        host        = coalesce(self.public_ip, self.private_ip)
        type        = "ssh"
        user        = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
    }
}

