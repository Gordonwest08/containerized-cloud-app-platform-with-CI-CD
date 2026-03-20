module "vpc" {
  source          = "../../modules/vpc"
  name            = "dev-vpc"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
}


module "iam" {
  source      = "../../modules/iam"
  name_prefix = "dev"
  env         = "dev"
  db_password = var.db_password
}

module "ecs" {
  source                 = "../../modules/ecs"
  cluster_name           = "dev-cluster"
  env                    = "dev"
  vpc_id                 = module.vpc.vpc_id
  subnets                = module.vpc.private_subnets
  public_subnets         = module.vpc.public_subnets
  region                 = var.region
  frontend_image         = var.frontend_image
  db_image               = var.db_image
  execution_role_arn     = module.iam.execution_role_arn
  task_role_arn          = module.iam.ecs_task_role_arn
  db_password_secret_arn = module.iam.db_password_secret_arn
}
