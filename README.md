# Containerized Cloud App Platform with CI/CD

This repository delivers a containerized application platform that runs on AWS Fargate with a modular Terraform codebase, isolated environments, and GitHub Action–driven lifecycle controls. The code is split into reusable infrastructure modules and environment-specific workspaces so production, development, bootstrap, and CI/CD workflows can evolve independently.

## Architecture Overview

```
┌──────────────┐      ┌─────────────┐      ┌─────────────┐      ┌──────────────┐
│ GitHub       │────▶│ Terraform   │────▶│ AWS Shared  │────▶│ AWS ECS App  │
│ Actions      │      │ Shared IAM  │      │ IAM/SSM/SM  │      │ (VPC + ALB + │
│ (CI/CD +     │      │ workspace   │      │ resources   │      │ ECS + Secrets)│
│ destroy prod)│      └─────────────┘      └─────────────┘      └──────────────┘
└──────────────┘            ▲                      ▲                  ▲
                             │                      │                  │
                             │                      │                  │
                          ┌──┴──────────┐       ┌───┴────────┐     ┌───┴────────┐
                          │ infra/modules│       │ infra/modules│     │ infra/modules│
                          │ - iam        │       │ - vpc        │     │ - ecs        │
                          └──────────────┘       └──────────────┘     └──────────────┘
```

The modules are wired into the shared IAM workspace (`infra/shared-iam`) and consumed via remote state in the environment workspaces under `infra/environments/{dev,prod}`. Production exposes its infrastructure through an S3-backed Terraform state bucket (the `terraform-bootstrap-state` backend) and a dedicated GitHub workflow for safe destruction.

## Key Components

- **Infrastructure Modules** (`infra/modules`)
  - `iam`: bootstraps IAM roles, policies, GitHub OIDC, Secrets Manager secrets, and parameter store entries.
  - `vpc`: builds a public/private VPC with subnets and gateway.
  - `ecs`: deploys an Application Load Balancer, ECS cluster, Fargate task definition, and CloudWatch logging for the containerized services.
- **Workspaces**
  - `infra/shared-iam`: central workspace that creates/reads shared IAM resources and publishes ARNs via outputs.
  - `infra/environments/dev` & `infra/environments/prod`: environment-specific stacks that consume the shared IAM outputs via remote state, provision the ECS cluster, and expose the application through an ALB.
- **CI/CD Integration**
  - `.github/workflows/infra-destroy-prod.yml`: manual dispatch workflow that assumes a GitHub Actions role, runs `terraform destroy` in the prod workspace, and requires an explicit confirmation token for safety.

## How to Use This Project

1. **Prerequisites**
   - AWS CLI credentials capable of assuming `arn:aws:iam::910541869155:role/github-actions-role` (used by GitHub Actions) and managing IAM, EC2, ECS, ELB, Secrets Manager, and SSM resources.
   - An S3 bucket `terraform-bootstrap-state` (or update the backend config) with a DynamoDB lock table if desired. Create it before initializing Terraform.
   - Docker images pushed to ECR: the sample references `910541869155.dkr.ecr.us-east-1.amazonaws.com/frontend:prod` and `db:prod`, as well as placeholder dev ones in the `.tfvars` files.

2. **Bootstrap Shared IAM**
   ```bash
   cd infra/shared-iam
   terraform init
   terraform plan
   terraform apply
   ```
   This workspace creates (or reads) the IAM resources, Secrets Manager secrets, and SSM parameters that are shared across environments. The remote-state bucket must already exist, otherwise Terraform cannot initialize the backend (the “bootstrap problem”).

3. **Deploy an Environment**
   The dev and prod workspaces both read the shared IAM outputs from the S3 backend.
   ```bash
   cd infra/environments/dev
   terraform init
   terraform plan
   terraform apply
   ```
   Replace `dev` with `prod` and make sure to point `terraform.tfvars` at the correct container images and AWS region.

4. **Destroy Production Safely**
   Use the GitHub Actions workflow `Destroy Prod Infrastructure`. It validates the confirmation token, assumes the GitHub Actions IAM role, and runs `terraform destroy` in the prod folder so manual deletes are auditable.

## Lessons Learned

1. **Bootstrap Problem**: Terraform’s S3 backend must be created before any workspace runs. The shared IAM workspace depends on `terraform-bootstrap-state`, so the bucket (and optionally a DynamoDB lock table) must exist ahead of time; otherwise `terraform init` will fail. Addressing this early prevents the “backend not found” errors that derail bootstrap attempts.
2. **Remote-State Coordination**: Decoupling IAM resources into a shared workspace avoids circular dependencies between environments. Always run the shared IAM applies before the environment workspaces so the remote-state data sources resolve the latest ARNs.
3. **Destroy Safeguards**: The manual GitHub workflow requires the user to type a sentinel value (`DESTROY-PROD`) before proceeding. Treat that pattern as a template for other sensitive tearing-down workflows.

## Reference Directory Map

- `infra/shared-iam`: shared IAM workspace with S3 backend and provider config.
- `infra/environments/dev` & `infra/environments/prod`: environment workspaces that configure the ECS app, VPC, and remote state dependence.
- `infra/modules`: reusable Terraform modules for IAM, VPC, and ECS.
- `.github/workflows`: GitHub Actions flows (e.g., production destroy).

## Next Steps / Tips

- Use `terraform workspace select` only if you split environments further; the current pattern relies on distinct directories.
- Keep secrets out of version control—replace the placeholder passwords in `infra/environments/*.tfvars` before running apply.
- Rebuild or extend `infra/modules/ecs/container` definitions if the app requires additional containers or sidecars.

For questions about the AWS account, IAM roles, or GitHub Actions configuration, consult the relevant team documentation or open an issue in this repo.
