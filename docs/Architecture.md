# Architecture

## Resources

Terraform provisions the following in a single resource group in UAE North:

- Virtual Network with two subnets: one for AKS nodes, one delegated to App Service
- AKS cluster (system node pool, autoscaling, Azure CNI + network policy)
- Azure Container Registry
- Azure Key Vault (RBAC authorization)
- Azure App Service (Linux, .NET 8) with VNet integration
- Azure App Configuration
- Storage Account

## How it connects

- The App Service has a system-assigned managed identity that is granted the
  "Key Vault Secrets User" role on the Key Vault, so the app reads secrets at
  runtime instead of storing them in configuration.
- AKS uses its kubelet managed identity, granted the "AcrPull" role on the ACR,
  to pull container images without registry credentials.
- The App Service integrates with the delegated subnet; AKS nodes sit in the
  AKS subnet.

## Application

The same .NET 8 API is deployed two ways: as a zip package to App Service, and
as a container (pushed to ACR) to AKS using the manifests in `kubernetes/`.

## Diagram

```
Resource Group (UAE North)
├── VNet
│   ├── snet-aks         -> AKS nodes
│   └── snet-appservice  -> App Service (VNet integrated)
├── AKS  --AcrPull-->  ACR
├── App Service  --Key Vault Secrets User-->  Key Vault
├── App Configuration
└── Storage Account
```
