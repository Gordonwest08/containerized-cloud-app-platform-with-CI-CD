variable "cluster_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "execution_role_arn" {
  type = string
}

variable "frontend_image" {
  type = string
}

variable "db_image" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "env" {
  type = string
}

variable "task_role_arn" {
  type = string
}

variable "db_password_secret_arn" {
  type = string
}