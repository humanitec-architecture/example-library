This section contains example Resource Definitions using the [Template Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) for Kubernetes objects.

* [`affinity.yaml`](./affinity.yaml): Add [affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) rules to the Workload.
* [`custom-namespace.yaml`](./custom-namespace.yaml): Create Kubernetes namespaces with your own custom naming scheme using the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [`custom-namespace.tf`](./custom-namespace.tf): Create Kubernetes namespaces with your own custom naming scheme using the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec).
* [`custom-workload-with-dynamic-labels.yaml`](./custom-workload-with-dynamic-labels.yaml): Add dynamic labels to your Workload.
* [`tolerations.yaml`](./tolerations.yaml): Add [tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) to the Workload.