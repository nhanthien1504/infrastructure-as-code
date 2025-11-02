# Documentation for Variables and Secrets

This document lists all the necessary CI/CD variables required for the application pipelines to run successfully. These variables should be configured in each application project's `Settings > CI/CD > Variables` section in GitLab.

## 1. Mandatory Variables (For All Pipelines)

These are required for the `prepare-deployment-context` job to function.

| Variable Name           | Example Value                                       | Description                                                                                                 | Protected | Masked |
| ----------------------- | --------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | --------- | ------ |
| `IAC_REPO_URL`          | `git@your-gitlab.com:group/infrastructure-as-code.git` | The SSH URL to this IaC repository. Used by pipelines to clone and read configuration files.                | Yes       | No     |
| `IAC_REPO_DEPLOY_KEY`   | `-----BEGIN OPENSSH PRIVATE KEY...`                 | The private SSH key of a **read-only** Deploy Key configured on the IaC repository.                         | Yes       | Yes    |

---

## 2. Platform-Specific Variables

Add the variables corresponding to the platform where the application will be deployed.

### For Kubernetes (EKS, AKS, On-premise)

| Variable Name   | Description                                                                                                                                                             | Type | Protected | Masked |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---- | --------- | ------ |
| `KUBE_CONFIG`   | The content of the `kubeconfig` file which provides credentials to access the Kubernetes cluster. This is typically generated after creating a cluster with Terraform. | File | Yes       | Yes    |

### For AWS Fargate

| Variable Name           | Example Value                               | Description                                                                                             | Protected | Masked |
| ----------------------- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------- | --------- | ------ |
| `AWS_ACCESS_KEY_ID`     | `AKIAIOSFODNN7EXAMPLE`                      | The access key for an IAM user with permissions to deploy to ECS/Fargate.                               | Yes       | Yes    |
| `AWS_SECRET_ACCESS_KEY` | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY`  | The corresponding secret access key.                                                                    | Yes       | Yes    |
| `AWS_DEFAULT_REGION`    | `ap-southeast-1`                            | The default AWS region where the Fargate cluster is located.                                            | Yes       | No     |

### For Virtual Machines (via Ansible)

| Variable Name             | Description                                                                                             | Protected | Masked |
| ------------------------- | ------------------------------------------------------------------------------------------------------- | --------- | ------ |
| `ANSIBLE_SSH_PRIVATE_KEY` | The private SSH key used by Ansible to connect to the target virtual machines for application deployment. | Yes       | Yes    |

---

## 3. Optional & Utility Variables

| Variable Name      | Description                                                                                                                            |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------- |
| `GRAFANA_API_URL`  | The URL for the Grafana API endpoint (e.g., `https://grafana.example.com`). Used by the `provision-grafana.sh` script.                 |
| `GRAFANA_API_TOKEN`| An API token with Admin privileges for Grafana, used to create data sources and dashboards automatically.                                |