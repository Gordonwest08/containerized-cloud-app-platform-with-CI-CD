variable "env" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "region" {
  type    = string
  default = "us-east-1"
}
