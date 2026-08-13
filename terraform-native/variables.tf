variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "CloudCart-Native"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.30.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.30.1.0/24"
}

variable "private_subnet_1_cidr" {
  type    = string
  default = "10.30.2.0/24"
}

variable "private_subnet_2_cidr" {
  type    = string
  default = "10.30.3.0/24"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type    = string
  default = "instance"
}

variable "db_name" {
  type    = string
  default = "cloud_cart_project"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "dynamodb_table_name" {
  type    = string
  default = "Cloud_Users"
}

variable "github_repo" {
  description = "CloudCart GitHub repository"
  type        = string
}

variable "github_branch" {
  description = "Git branch"
  type        = string
  default     = "main"
}
