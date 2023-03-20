variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}
variable "project_name" {
  description = "name of the project"
  type        = string
  default     = "panda"
}
variable "environment" {
  description = "name of the environment"
  type        = string
  default     = "devel"
}
variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "muhayu-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["ap-northeast-2a"]
}
variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24"]
}
variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = false
}
variable "root_password" {
  description = "password"
  type         = string
  default      = "8wjsurzhRlfl?"
}
