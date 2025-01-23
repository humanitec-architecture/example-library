This section shows how to use the [Template Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) for configuring cluster access to a private container image registry.

The example implements the Kubernetes standard mechanism to [Pull an Image from a Private Registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/). It creates a Kubernetes Secret of `kubernetes.io/dockerconfigjson` type, reading the credentials from a secret store. It then configures the secret as the `imagePullSecret` for a Workload's Pod.

The example requires the [Humanitec Operator](https://developer.humanitec.com/integration-and-extensions/humanitec-operator/overview/) to be configured on the cluster and connected to a secret store. The Resource Definition of type `config` will then read the credentials for the `imagePullSecret` from that secret store to populate the actual Kubernetes secret.

To use this mechanism, install the Resource Definitions of this example into your Organization, replacing some placeholder values with the actual values of your setup. Add the appropriate [matching criteria](https://developer.humanitec.com/platform-orchestrator/resources/resource-definitions/#matching-criteria) to the `workload` Definition to match the Workloads you want to have access to the private registry.

> Note: `workload` is an [implicit Resource Type](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#resource-type-use) so it is automatically referenced for every Deployment.

- [config.yaml](config.yaml): Resource Definition of `type: config` that reads the credentials for the private registry from a secret store and creates the Kubernetes Secret
- [workload.yaml](workload.yaml): Resource Definition of `type: workload` that adds the `imagePullSecrets` element to the Pod spec, referencing the `config` Resource