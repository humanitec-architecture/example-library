# Credentials

## Using static credentials

This section contains example Resource Definitions using static credentials for connecting to generic Kubernetes clusters.

* [generic-k8s-client-certificate.tf](generic-k8s-client-certificate.tf): use a [client certificate](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#x509-client-certificates) to connect to the cluster. This format is for use with the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec)
* [generic-k8s-static-credentials.yaml](generic-k8s-client-certificate.yaml): use a [client certificate](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#x509-client-certificates) to connect to the cluster. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).