# Credentials

## Using static credentials

This section contains example Resource Definitions using static credentials for connecting to EKS clusters.

* [eks-static-credentials.yaml](eks-static-credentials.yaml): use static credentials defined via environment variables. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [eks-static-credentials-cloudaccount.yaml](eks-static-credentials-cloudaccount.yaml): use static credentials defined via a [Cloud Account](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/). This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).

## Using temporary credentials

This section contains example Resource Definitions using temporary credentials for connecting to EKS clusters.

* [eks-temporary-credentials.yaml](eks-temporary-credentials.yaml): use temporary credentials defined via a Cloud Account. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)
* [eks-temporary-credentials.tf](eks-temporary-credentials.tf): uses temporary credentials defined via a Cloud Account. This format is for use with the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec)