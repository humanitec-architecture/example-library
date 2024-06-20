# Credentials

## Using static credentials

This section contains example Resource Definitions using static credentials for connecting to AKS clusters.

* [aks-static-credentials.yaml](aks-static-credentials.yaml): use static credentials of a service principal defined via environment variables. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [aks-static-credentials-cloudaccount.yaml](aks-static-credentials-cloudaccount.yaml): use static credentials defined via a [Cloud Account](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/). This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).

## Using dynamic credentials

This section contains example Resource Definitions using [dynamic credentials](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/azure/#azure-workload-identity-federation) for connecting to AKS clusters.

* [aks-dynamic-credentials.yaml](aks-dynamic-credentials.yaml): use dynamic credentials defined via a Cloud Account. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)
* [aks-dynamic-credentials.tf](aks-dynamic-credentials.tf): uses dynamic credentials defined via a Cloud Account. This format is for use with the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec)