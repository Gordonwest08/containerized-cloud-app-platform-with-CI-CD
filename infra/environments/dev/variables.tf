variable "region" {}
variable "frontend_image" {}
variable "db_image" {}




variable "db_password" {
  sensitive = true
}