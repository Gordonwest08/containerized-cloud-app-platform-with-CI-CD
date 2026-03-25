variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "env" {
  description = "Environment name (dev, prod)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for IAM resources"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}