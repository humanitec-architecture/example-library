# Credentials

## Using static credentials

This section contains example Resource Definitions using static credentials for connecting to AKS clusters.

* [aks-static-credentials.yaml](aks-static-credentials.yaml): use static credentials of a service principal defined via environment variables. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [aks-static-credentials-cloudaccount.yaml](aks-static-credentials-cloudaccount.yaml): use static credentials defined via a [Cloud Account](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/). This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).

## Using temporary credentials

This section contains example Resource Definitions using [temporary credentials](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/azure/#azure-workload-identity-federation) for connecting to AKS clusters.

* [aks-temporary-credentials.yaml](aks-temporary-credentials.yaml): use temporary credentials defined via a Cloud Account. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)
* [aks-temporary-credentials.tf](aks-temporary-credentials.tf): uses temporary credentials defined via a Cloud Account. This format is for use with the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec)