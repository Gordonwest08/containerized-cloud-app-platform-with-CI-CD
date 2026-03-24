resource "aws_iam_role_policy_attachment" "github_actions_admin" {
  role       = data.aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  lifecycle {
    prevent_destroy = true
  }
}
