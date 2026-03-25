############################################
# Environment
############################################

variable "region" {
  description = "AWS region"
  type        = string
}

############################################
# Images
############################################

variable "frontend_image" {
  description = "Frontend image URI (ECR)"
  type        = string
}

variable "db_image" {
  description = "Database image URI (ECR)"
  type        = string
}

############################################
# Secrets
############################################

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}