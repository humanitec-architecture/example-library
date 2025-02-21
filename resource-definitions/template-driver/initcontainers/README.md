This section contains example Resource Definitions using the [Template Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/template/) for defining an [init container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) on your Pods.

While it is also possible to [set init containers via Score](https://developer.humanitec.com/examples/score/initcontainers/), the approach shown here shifts the management of init containers down to the Platform, ensuring consistency and relieving developers of the task to repeat them for each Workload in the Score extension file.

* [`custom-workload-with-initcontainer.yaml`](./custom-workload-with-initcontainer.yaml): Add the required init container to the Workload so it polls for the existence of a Kubernetes service for the Workload. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [`custom-workload-with-initcontainer.tf`](./custom-workload-with-initcontainer.tf):  This format is for use with the [Humanitec Terraform Provider](https://registry.terraform.io/providers/humanitec/humanitec).
