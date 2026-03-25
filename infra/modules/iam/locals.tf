locals {
  execution_role_name = "${var.name_prefix}-ecs-exec-role"
  task_role_name = "${var.env}-ecs-task-role"
  github_oidc_provider_arn = var.github_oidc_provider_arn != "" ? var.github_oidc_provider_arn : try(
    data.aws_iam_openid_connect_provider.github.arn,
    format("arn:aws:iam::%s:oidc-provider/token.actions.githubusercontent.com", data.aws_caller_identity.current.account_id)
  )
}
