output "execution_role_arn" {
  value = module.iam.execution_role_arn
}

output "ecs_task_role_arn" {
  value = module.iam.ecs_task_role_arn
}

output "db_password_secret_arn" {
  value = module.iam.db_password_secret_arn
}

output "github_oidc_provider_arn" {
  value = module.iam.github_oidc_provider_arn
}
