variable "name" {
  description = "Name prefix for VPC resources"
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}


variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}