﻿# infrastructure-as-code

This mono-repository contains all the Infrastructure as Code (IaC) definitions and CI/CD templates for managing our application platforms.

## 🚀 Guiding Principles

- **Single Source of Truth (SSoT)**: All infrastructure, configurations, and deployment logic are version-controlled here.
- **Automation**: Automate everything from infrastructure provisioning to application deployment and monitoring configuration.
- **GitOps**: Git is the central mechanism for driving changes to the system.

## 📂 Repository Structure

| Directory             | Purpose                                                                                             |
| --------------------- | --------------------------------------------------------------------------------------------------- |
| `config/`             | **SSoT**: Defines all projects, environments, and platform mappings. **Start here!**                |
| `terraform/`          | Contains Terraform code to provision cloud infrastructure (EKS, Fargate, VMs).                      |
| `ansible/`            | Contains Ansible playbooks and roles for configuring VMs.                                           |
| `ci-cd-templates/`    | **Core CI/CD Logic**: Reusable GitLab CI templates for building and deploying applications.         |
| `kubernetes/`         | Base Kubernetes manifests used by Kustomize.                                                        |
| `monitoring/`         | Configuration for our observability stack (Prometheus, Grafana, Loki).                              |
| `scripts/`            | Helper scripts for bootstrapping and automation tasks.                                              |
| `docs/`               | Detailed documentation, architecture diagrams, and guides.                                          |

## 📖 Getting Started

1.  **Understand the Configuration**:
    - Read `config/README.md` (you may need to create this) to understand how projects and environments are defined.

2.  **Review the CI/CD Variables**:
    - All required CI/CD variables are documented in **docs/variables-and-secrets.md**. You must configure these in your application's GitLab project settings.

3.  **Provision Infrastructure**:
    - The pipeline in `/.gitlab-ci.yml` is used to run Terraform. Navigate to the `terraform/environments/` directory to see how infrastructure is defined.

4.  **Include the CI/CD Template**:
    - In your application's `.gitlab-ci.yml`, include the main dispatcher template:
      ```yaml
      include:
        - project: 'your-group/infrastructure-as-code'
          ref: main
          file: '/ci-cd-templates/complete/.gitlab-ci-complete.yml'
      ```
