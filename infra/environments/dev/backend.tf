terraform {
  backend "s3" {
    bucket = "gordonwest-terraform-state"
    key    = "ecs/terraform.tfstate"
    region = "us-east-1"
  }
}
