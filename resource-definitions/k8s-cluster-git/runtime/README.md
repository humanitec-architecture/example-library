## Connecting to a Git repository (GitOps mode)

This section contains example Resource Definitions for connecting to a Git repository to push application CRs ([GitOps mode](https://developer.humanitec.com/integration-and-extensions/humanitec-operator/architecture/#modes-of-operation-humanitec-operator-with-gitops-mode)).

It also provides a solution to specify the non GitOps-cluster where the GitOps deploys workloads. The Orchestrator will connect to it to retrieve information about the deployed workload status.

* [github-for-gitops.yaml](github-for-gitops.yaml): contains configuration for connecting to a Git repository. This Resource Definition co-provisions a [GKE cluster](https://developer.humanitec.com/platform-orchestrator/examples/resource-definitions/#k8s-cluster-gke) to be used to fetch Runtime Information. This format is for use with the [Humanitec CLI](<https://developer.humanitec.com/>).
* [gke-temporary-credentials-runtime.yaml](gke-temporary-credentials-runtime.yaml): uses temporary credentials defined via a Cloud Account. The Resource Id specified in the Matching Criteria ensures that this Definition will be matched to provision the Resource co-provisioned by the GitOps cluster Resource Definition. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/)
* [`custom-namespace.yaml`](./custom-namespace.yaml): Shows how to use the Echo Driver to return the name of an externally managed namespace that must match the namespace where the GitOps Operator creates the resources. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
