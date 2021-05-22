variable "ENV" {}
variable "PRIVATE_SUBNETS" {}
variable "DB_SECURITY_GROUP" {}
variable "POSTGRES_USERNAME" {}
variable "POSTGRES_PASSWORD" {}

variable "AWS_REGION" {
    default = "us-east-1"
}
variable "POSTGRES_NAME" {
    default = "postgresql"
}
variable "POSTGRES_PORT" {
    default = 5432
}