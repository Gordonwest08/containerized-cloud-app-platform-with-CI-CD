output "execution_role_arn" {
  value = aws_iam_role.ecs_execution.arn
}

output "db_password_secret_arn" {
  value = aws_secretsmanager_secret.db_password.arn
}

output "ssm_parameter_prefix" {
  value = "/${var.env}/"
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}