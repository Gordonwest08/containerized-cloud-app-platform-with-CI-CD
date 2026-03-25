variable "name_prefix" {
  type = string
}


variable "env" {
  type = string
}

variable "github_oidc_provider_arn" {
  description = "Optional ARN of an existing GitHub OIDC provider to reuse (skips creation when set)"
  type        = string
  default     = ""
}
