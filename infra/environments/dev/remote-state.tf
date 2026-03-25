#This tells terraform: Go read outputs from the shared IAM state"
data "terraform_remote_state" "shared_iam" {
  backend = "s3"

  config = {
    bucket = "terraform-bootstrap-state"
    key    = "shared-iam/terraform.tfstate"
    region = "us-east-1"
  }
}