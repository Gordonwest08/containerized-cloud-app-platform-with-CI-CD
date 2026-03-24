locals {
  ecs_execution_role_name = "${var.name_prefix}-ecs-execution-role"
  ecs_task_role_name      = "${var.name_prefix}-ecs-task-role"
  secrets_prefix          = "${var.env}2/db"
  ssm_prefix              = "/${var.env}/app"
}
