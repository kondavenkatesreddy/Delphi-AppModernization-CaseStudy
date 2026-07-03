# Design Decisions

## Modules
Each service is a module under `terraform/modules`. The root composes them and
wires outputs between modules (for example, the ACR id and the AKS kubelet
identity are used to create the AcrPull role assignment). This keeps each
service self-contained and lets the same modules be reused across dev/uat/prod
by changing only the tfvars.

## Managed identities instead of secrets
- App Service uses a system-assigned identity with the "Key Vault Secrets User"
  role, so no secrets are stored in app settings.
- AKS pulls from ACR with its kubelet identity and the AcrPull role, so there
  are no registry credentials in Kubernetes or the pipelines.

## Networking
Azure CNI is used (not kubenet) so pods get real VNet IPs and Azure network
policy can be applied. The AKS service CIDR (172.16.0.0/16) is kept outside the
VNet range (10.10.0.0/16) to avoid any overlap. The App Service subnet is
delegated to Microsoft.Web/serverFarms for VNet integration.

## Security defaults
- Key Vault uses RBAC authorization and soft delete.
- Storage enforces TLS 1.2, HTTPS only, and blocks public blob access.
- ACR admin user is disabled.
- App Service is HTTPS only, TLS 1.2 minimum, FTPS disabled.

## Environments
`vars/dev.tfvars` is the working configuration. `uat.tfvars` and `prod.tfvars`
carry the same shape with larger SKUs/node sizing for those environments.

## Application
The sample API is intentionally minimal - it exposes a `/health` endpoint that
both App Service and the Kubernetes probes use. It is deployed to App Service as
a package and to AKS as a container to cover both paths in the assignment.

## Notes / simplifications
- The Kubernetes ingress assumes an NGINX ingress controller is already
  installed on the cluster (installed separately via Helm).
- Monitoring is accounted for in the BOQ as a cost item; it is not provisioned
  in Terraform because task 1 only lists AKS, ACR, Key Vault and App Service.
- Availability Zones and reserved instances are discussed in the BOQ as the
  production recommendation rather than forced into the dev code.
