# Delphi App Modernization - Case Study

This repository contains the Terraform infrastructure, Azure DevOps pipelines,
Kubernetes manifests and a sample .NET application created as part of the
Delphi App Modernization assignment.

## Structure

terraform/   - Terraform code (modules + root composition, vars per environment)
pipelines/   - Azure DevOps YAML pipelines
kubernetes/  - Kubernetes manifests for the sample microservice
sample-app/  - Sample .NET 8 API + Dockerfile
docs/        - Architecture notes, design decisions and the BOQ

## Terraform

Modules are under `terraform/modules` (one per service: resource_group, network,
storage, app_configuration, key_vault, acr, aks, app_service). The root
`main.tf` composes them and passes outputs between them. Environment values are
in `terraform/vars/{dev,uat,prod}.tfvars`.

#bash
cd terraform
terraform init
terraform validate
terraform plan  -var-file=vars/dev.tfvars
terraform apply -var-file=vars/dev.tfvars

State: backend.tf has a commented azurerm backend block. For a quick run it
uses local state, uncomment and configure the backend for remote state.

## Application

sample-app/Delphi.SampleApi is a minimal .NET 8 API with "/", "/health" and
"/config" endpoints. It deploys two ways:

- To App Service as a zip package ("pipelines/dotnet-appservice-pipeline.yml")
- To AKS as a container image built and pushed to ACR
  ("pipelines/docker-acr-pipeline.yml", then the manifests in "kubernetes/")

## Pipelines (Azure DevOps)

Three YAML pipelines are under "pipelines/". Each is imported once in Azure DevOps
(Pipelines > New pipeline > GitHub > Existing YAML file) and then triggers
automatically on a push to "main" that touches the relevant paths.

| Pipeline | File | Purpose | Trigger |
|----------|------|---------|---------|
| Terraform infra | `pipelines/terraform-infra-pipeline.yml` | init / validate / plan / apply | push to `main` under `terraform/*` |
| .NET to App Service | `pipelines/dotnet-appservice-pipeline.yml` | build .NET 8 app, deploy to App Service | push to `main` under `sample-app/*` |
| Image to ACR | `pipelines/docker-acr-pipeline.yml` | build container image, push to ACR | push to `main` under `sample-app/*` |

Before the first run, create in Azure DevOps:
- A **service connection** to the Azure subscription named "delphi-azure-sc"
  (and "delphi-acr-sc" for the ACR pipeline).

To create the Azure DevOps pipelines from this repository, use the YAML paths below:

```bash
az pipelines create --name "Terraform Infra Pipeline" \
  --repository "kondavenkatesreddy/Delphi-AppModernization-CaseStudy" \
  --branch main \
  --repository-type github \
  --yml-path "pipelines/terraform-infra-pipeline.yml" \
  --service-connection "Delphi-Github-connection" \
  --skip-first-run true

az pipelines create --name "Docker ACR Pipeline" \
  --repository "kondavenkatesreddy/Delphi-AppModernization-CaseStudy" \
  --branch main \
  --repository-type github \
  --yml-path "pipelines/docker-acr-pipeline.yml" \
  --service-connection "Delphi-Github-connection" \
  --skip-first-run true

az pipelines create --name "Dotnet AppService Pipeline" \
  --repository "kondavenkatesreddy/Delphi-AppModernization-CaseStudy" \
  --branch main \
  --repository-type github \
  --yml-path "pipelines/dotnet-appservice-pipeline.yml" \
  --service-connection "Delphi-Github-connection" \
  --skip-first-run true
```

Trigger options:

```bash
# Automatic: any push to main under the watched path starts the pipeline
git push origin main

# Manual: in Azure DevOps -> Pipelines -> select pipeline -> "Run pipeline"
```

## Kubernetes

`kubernetes/` contains the Deployment, Service, Ingress, HPA, StorageClass and
PVC for the sample microservice. Assumes an NGINX ingress controller is present
on the cluster.

Connect to the AKS cluster and deploy:

```bash
# 1. Get cluster credentials
az aks get-credentials --resource-group rg-delphi-dev-uaen-001 --name aks-delphi-dev-uaen-001

# 2. (one time) install the NGINX ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml

# 3. Apply the manifests
kubectl apply -f kubernetes/
```

Verify the deployment:

```bash
kubectl get nodes                 # cluster nodes are Ready
kubectl get pods                  # pods Running
kubectl get svc                   # service + ClusterIP
kubectl get ingress               # ingress + address
kubectl get hpa                   # autoscaler + current/target CPU
kubectl describe deployment sample-microservice
kubectl logs deploy/sample-microservice
```

Useful checks:

```bash
kubectl get pods -o wide          # which node each pod is on
kubectl rollout status deployment/sample-microservice
kubectl top pods                  # CPU/memory (needs metrics-server)
```

## Git workflow

```bash
# Clone
git clone https://github.com/kondavenkatesreddy/Delphi-AppModernization-CaseStudy.git
cd Delphi-AppModernization-CaseStudy

# Make changes, then stage and commit
git add -A
git status
git commit -m "your message"

# Push to GitHub (this also triggers the pipelines)
git push origin main
```

## Documentation

- `docs/Architecture.md` - what is deployed and how it connects
- `docs/Design-Decisions.md` - the reasoning behind the main choices
- `docs/BOQ-UAE-North.md` - Bill of Quantity for UAE North (incl. monitoring & security)