module "vpc" {
  source          = "../../modules/vpc"
  name            = "prod-vpc"
  cidr_block      = "10.1.0.0/16"
  public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.11.0/24", "10.1.12.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
}

module "ecs" {
  source         = "../../modules/ecs"
  cluster_name   = "prod-cluster"
  env            = "prod"
  vpc_id         = module.vpc.vpc_id
  subnets        = module.vpc.private_subnets
  public_subnets = module.vpc.public_subnets
  region         = var.region

  frontend_image = var.frontend_image
  db_image       = var.db_image

  execution_role_arn     = data.terraform_remote_state.shared_iam.outputs.execution_role_arn
  task_role_arn          = data.terraform_remote_state.shared_iam.outputs.ecs_task_role_arn
  db_password_secret_arn = data.terraform_remote_state.shared_iam.outputs.db_password_secret_arn
}