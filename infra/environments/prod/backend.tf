terraform {
  backend "s3" {
    bucket  = "terraform-state-prod120"
    key     = "ecs/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true

  }
}