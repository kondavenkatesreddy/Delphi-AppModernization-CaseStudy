# Bill of Quantity (BOQ) - UAE North

Region: UAE North (uaenorth). Currency: USD. Basis: pay-as-you-go, Linux,
730 hours/month.

Prices below are indicative UAE North list prices (mid-2026 references). The
authoritative figures for a proposal should be taken from the Azure Pricing
Calculator for the exact SKUs, and reserved instances (1 or 3 year) can reduce
compute by roughly 30-40% for steady workloads.

## Core resources

| # | Service | SKU / Config | Qty | Est. monthly (USD) |
|---|---------|--------------|-----|--------------------|
| 1 | AKS control plane | Standard tier (uptime SLA) | 1 | ~73 |
| 2 | AKS worker nodes | Standard_B2s (dev) / D2s_v5 (prod) | 2 | ~60 (dev) / ~210 (prod) |
| 3 | AKS node disks + load balancer | StandardSSD + Standard LB | - | ~30 |
| 4 | Azure Container Registry | Standard (dev) / standard (prod) | 1 | ~20 / ~50 |
| 5 | Azure Key Vault | Standard, RBAC | 1 | ~5 |
| 6 | App Service Plan | B1 (dev) / P1v3 (prod) | 1 | ~13 / ~146 |
| 7 | App Configuration | Standard | 1 | ~36 |
| 8 | Storage Account | Standard LRS | 1 | ~5 |

## Monitoring and security

| # | Item | Config | Est. monthly (USD) |
|---|------|--------|--------------------|
| 9  | Log Analytics workspace | ~5-10 GB/month ingest | ~15 |
| 10 | Container Insights (AKS) | via Log Analytics | included in #9 |
| 11 | Application Insights | ~5 GB telemetry | ~14 |
| 12 | Microsoft Defender for Containers | per vCPU | ~40 |
| 13 | Microsoft Defender for App Service | per instance | ~15 |

## Indicative totals

- Dev environment: ~180-220/month
- Production environment (with monitoring + Defender): ~650-750/month
  (drops ~30-40% on compute with 1-year reservations)

## Cost optimization notes

- Use the AKS Free control-plane tier and cluster autoscaler with a low minimum
  in dev.
- Reserved instances / savings plans for prod AKS nodes and the App Service Plan.
- App Configuration Free tier in dev (Standard is often the biggest dev line item).
- Tag resources (Project/Environment/Owner) and set Cost Management budgets.

## Assumptions

- 730 hours/month, single region, no DR pairing costed.
- Egress/data transfer estimated, not metered.
- Prices exclude EA/CSP discounts and taxes.
