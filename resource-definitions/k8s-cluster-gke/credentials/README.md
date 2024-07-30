# Credentials

## Using static credentials

This section contains example Resource Definitions using static credentials for connecting to GKE clusters.

* [gke-static-credentials.yaml](gke-static-credentials.yaml): use static credentials defined via environment variables. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [gke-static-credentials-cloudaccount.yaml](gke-static-credentials-cloudaccount.yaml): use static credentials defined via a [Cloud Account](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/). This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).

## Using temporary credentials

This section contains example Resource Definitions using temporary credentials for connecting to GKE clusters.

* [gke-temporary-credentials.yaml](gke-temporary-credentials.yaml): use temporary credentials defined via a Cloud Account. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)
* [gke-temporary-credentials.tf](gke-temporary-credentials.tf): uses temporary credentials defined via a Cloud Account. This format is for use with the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec)