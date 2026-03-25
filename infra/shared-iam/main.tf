module "iam" {
  source      = "../modules/iam"
  env         = var.env
  name_prefix = var.name_prefix
}
