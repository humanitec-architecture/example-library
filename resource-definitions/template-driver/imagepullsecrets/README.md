This section shows how to use the [Template Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) for configuring cluster access to a private container image registry.

The example implements the Kubernetes standard mechanism to [Pull an Image from a Private Registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/). It creates a Kubernetes Secret of `kubernetes.io/dockerconfigjson` type, reading the credentials from a secret store. The example therefore requires the [Humanitec Operator](https://developer.humanitec.com/integration-and-extensions/humanitec-operator/overview/) to be set up for the cluster.

The example then configures the secret as the `imagePullSecret` for a Workload's Pod.

To use this mechanism, install the Resource Definitions of this example into your Organization, and add the appropriate [matching criteria](https://developer.humanitec.com/platform-orchestrator/resources/resource-definitions/#matching-criteria) to the `workload` Definition to match the Workloads you want to have access to the private registry.

> Note: `workload` is an [implicit Resource Type](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#resource-type-use) so it is automatically referenced for every Deployment.

- [config.yaml](config.yaml): Resource Definition of `type: config` that reads the credentials for the private registry from a secret store and creates the Kubernetes Secret
- [workload.yaml](workload.yaml): Resource Definition of `type: workload` that adds the `imagePullSecrets` element to the Pod spec, referencing the `config` Resource