variable "PUBLIC_SUBNETS" {}
variable "SECURITY_GROUP_INSTANCE_ID" {}
variable "ELB_NAME" {}

variable "INSTALL_SOFTWARE" {
    default = "../scripts/script.sh"
}

variable "AWS_REGION" {
    default = "us-east-1"
}

variable "AMIS" {
    type = map(string)
    default = {
        us-east-1 = "ami-042e8287309f5df03"
    }
}

variable INSTANCE_TYPE {
    default     = "t2.micro"
}

variable "PATH_TO_PRIVATE_KEY" {
    default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
    default = "ubuntu"
}
