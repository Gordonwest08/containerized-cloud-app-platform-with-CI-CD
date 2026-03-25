terraform {
  backend "s3" {
    bucket  = "terraform-bootstrap-state"
    key     = "shared-iam/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
