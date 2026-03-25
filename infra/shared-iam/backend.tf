terraform {
  backend "s3" {
    bucket       = "gordonwest-terraform-state"
    key          = "shared-iam/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}