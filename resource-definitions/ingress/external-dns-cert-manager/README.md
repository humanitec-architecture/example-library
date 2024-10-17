This section contains example Resource Definitions for using [External DNS](https://kubernetes-sigs.github.io/external-dns/latest/) and [Cert Manager](https://cert-manager.io/docs/) by setting annotations in the [Ingress](https://developer.humanitec.com/integration-and-extensions/drivers/k8-drivers/ingress/)

- [dns.yaml](./dns.yaml) generates a DNS subdomain that can then be used by External DNS to create the DNS record.
- [ingress.yaml](./ingress.yaml) creates a Kubernetes Ingress resource with the following annotations:
  - `cert-manager.io/cluster-issuer` - set to the cluster issuer already defined in the cluster. ([Cert Manager Ingress Annotations](https://cert-manager.io/docs/usage/ingress/#supported-annotations))
  - `external-dns.alpha.kubernetes.io/hostname` - set to a resource reference to the DNS that the ingress is for. ([External DNS Ingress Annotation Hostname](https://kubernetes-sigs.github.io/external-dns/latest/docs/annotations/annotations/#external-dnsalphakubernetesiohostname))

Before using the above examples, ensure that:
- [External DNS](https://kubernetes-sigs.github.io/external-dns/latest/charts/external-dns/) and [Cert Manager](https://cert-manager.io/docs/installation/) operators are installed and configured in the cluster,
- matching criteria in both resource definitions are updated,
- the Cluster Issuer Annotation in the Ingress resource is updated and
- the super domain in the dns resource definition.