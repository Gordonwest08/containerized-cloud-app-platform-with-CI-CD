output "github_actions_role_arn" {
  value       = aws_iam_role.github_actions.arn
  description = "Role ARN to use in GitHub Actions"
}

output "shared_iam_state_bucket_name" {
  value       = aws_s3_bucket.shared_iam_state.bucket
  description = "Bucket that stores the shared IAM remote state"
}

output "shared_iam_state_bucket_arn" {
  value       = aws_s3_bucket.shared_iam_state.arn
  description = "ARN of the shared IAM backend bucket"
}
