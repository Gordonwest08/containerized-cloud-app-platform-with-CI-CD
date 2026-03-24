resource "aws_ssm_parameter" "app_env" {
  name  = "${local.ssm_prefix}/env"
  type  = "String"
  value = var.env
}

resource "aws_ssm_parameter" "app_port" {
  name  = "${local.ssm_prefix}/port"
  type  = "String"
  value = "3000"
}