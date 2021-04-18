variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
    default = "us-east-1"
}

variable "AMIS" {
    type = map(string)
    default = {
        us-east-1 = "ami-013f17f36f8b1fefb"
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
