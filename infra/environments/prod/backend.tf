terraform {
  backend "s3" {
    bucket         = "terraform-state-prod"
    key            = "ecs/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-prod"
  }
}