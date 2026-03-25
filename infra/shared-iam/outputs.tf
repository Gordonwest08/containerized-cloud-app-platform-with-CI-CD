


output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_execution.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "db_password_secret_arn" {
  value = aws_secretsmanager_secret.db_password.arn
}

output "ssm_parameter_prefix" {
  value = local.ssm_prefix
}