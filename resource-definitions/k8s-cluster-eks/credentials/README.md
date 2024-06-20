# Credentials

## Using static credentials

This section contains example Resource Definitions using static credentials for connecting to EKS clusters.

* [eks-static-credentials.yaml](eks-static-credentials.yaml): use static credentials defined via environment variables. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [eks-static-credentials-cloudaccount.yaml](eks-static-credentials-cloudaccount.yaml): use static credentials defined via a [Cloud Account](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/). This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).

## Using dynamic credentials

This section contains example Resource Definitions using dynamic credentials for connecting to EKS clusters.

* [eks-dynamic-credentials.yaml](eks-dynamic-credentials.yaml): use dynamic credentials defined via a Cloud Account. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)
* [eks-dynamic-credentials.tf](eks-dynamic-credentials.tf): uses dynamic credentials defined via a Cloud Account. This format is for use with the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec)