# ⚠️ BOOTSTRAP INFRA — DO NOT DESTROY

This Terraform stack provisions:
- GitHub OIDC Provider
- GitHub Actions IAM Role

## Rules
- Run locally only
- Never destroyed
- Not managed by CI/CD
- Required for all pipelines to function

Destroying this stack will break all CI/CD