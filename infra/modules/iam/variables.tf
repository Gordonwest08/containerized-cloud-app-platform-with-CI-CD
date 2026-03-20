variable "name_prefix" {
  type = string
}


variable "env" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}