This example shows a sample usage of the `base-env` Resource Type. It is one of the _implicit_ [Resource Types](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/) that always gets provisioned for a Deployment.

In this example, it will be used to provision multiple Kubernetes resources scoped to the Namespace: [ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/) and [NetworkPolicies](https://kubernetes.io/docs/concepts/services-networking/network-policies/):

- The Resource Definition [base-env-resource-quota.yaml](./base-env-resource-quota.yaml) uses the `template` driver to provision a Kubernetes manifest describing a [ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/) in the target namespace.
- The Resource Definition [base-env-network-policies.yaml](./base-env-network-policies.yaml) uses the `template` driver to provision a Kubernetes manifest describing a [NetworkPolicies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) in the target namespace.

Splitting provisioning of the two Kubernetes Resources in two different Resource Definitions allows to:

- Keep modularity: the same `base-env-resource-quota` (or `base-env-network-policies`) Resource Definition can be used by different `base-env-default`.
- Allow flexibility: every `base-env` can use a different Resource Driver (e.g. `template`, `terraform`).

The [base-env-default.yaml](./base-env-default.yaml) Resource Definition creates a dependency on the other two `base-env` Resource Definitions using a [Resource Reference](https://developer.humanitec.com/platform-orchestrator/resources/resource-graph/#resource-references). The reference specifies different Resource IDs (`resource-quota` and `network-policies`) so that the proper `base-env` Resource Definitions will be matched based on their matching criteria.

Three `base-env` Resource Definitions are provided:

- [base-env-default.yaml](./base-env-default.yaml) to add the `base-env` Resources that provision the Kubernetes manifests to the [Resource Graph](https://developer.humanitec.com/platform-orchestrator/resources/resource-graph/)
- [base-env-resource-quota.yaml](./base-env-resource-quota.yaml) will be matched for all references of `res_id: resource-quota`
- [base-env-network-policies.yaml](./base-env-network-policies.yaml) will be matched for all references of `res_id: network-policies`
