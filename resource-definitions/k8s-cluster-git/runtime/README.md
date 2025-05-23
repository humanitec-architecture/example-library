## Connecting to a Git repository (GitOps mode)

This section contains example Resource Definitions for connecting to a Git repository to push application CRs in [GitOps mode](https://developer.humanitec.com/integration-and-extensions/humanitec-operator/architecture/#modes-of-operation-gitops-mode).

More specifically, it provides a solution to securely tap into the cluster where the actual workloads run and read runtime information like Pod status or container logs through the Platform Orchestrator.

To retrieve the status of deployed workloads, the Orchestrator searches for a `k8s-cluster` Resource with the Id `k8s-cluster-runtime`. If it doesn't find this resource, it defaults to the `k8s-cluster` resource with the Id `k8s-cluster`. When the default cluster is a GitOps-managed cluster, an additional non-GitOps cluster is required to gather runtime information for workloads deployed by the GitOps operator. This example demonstrates that process.

The namespace name where the Orchestrator will look for the Kubernetes objects to gather runtime information is retrieved from the Active Resource of type `k8s-namespace`. Note that in GitOps mode, the namespace is an externally managed Resource, i.e. the Platform Orchestrator does not create the namespace. It is recommended to use a namespace Resource Definition based on the [Echo Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/echo/) to reflect this fact. This also means that any customization of the namespace, such as adding specific labels, must be managed externally.

The chart illustrates the setup. Because `k8s-cluster` is an [_implicit_  Resource Type](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#resource-type-use), one such Resource is always matched for any Deployment. This creates the Resource representing the GitOps cluster, using the `k8s-cluster-git` Driver. That resource co-provisions another Resource of type `k8s-cluster` with the Id `k8s-cluster-runtime` and the `k8s-cluster-gke` Driver, representing the runtime cluster.

```mermaid
flowchart LR
  subgraph implicitResources[Implicit Resources]
    k8s-namespace(id: k8s-namespace<br/>type: k8s-namespace<br/>Driver: echo)
    workload(id: workload<br/>type: workload) ~~~ k8s-cluster-gitops(id: k8s-cluster<br/>type: k8s-cluster<br/>Driver: k8s-cluster-git)
  end
  k8s-cluster-gitops --o|co-provision| k8s-cluster-runtime(id: k8s-cluster-runtime<br/>type: k8s-cluster<br/>Driver: k8s-cluster-gke)
  platformOrchestrator{Platform<br/>Orchestrator} -.->|Deploy K8s CRs to<br/>Git repo through| k8s-cluster-gitops
  platformOrchestrator -.->|Determine<br/>namespace from| k8s-namespace
  platformOrchestrator -.->|Obtain runtime information from| k8s-cluster-runtime
```

These files make up the example:

* [`github-for-gitops.yaml`](github-for-gitops.yaml): contains configuration for connecting to a Git repository. This Resource Definition co-provisions a [GKE cluster](https://developer.humanitec.com/platform-orchestrator/examples/resource-definitions/#k8s-cluster-gke) to be used to fetch Runtime Information, the `k8s-cluster-runtime` Id is used in the co-provision key. This format is for use with the [Humanitec CLI](<https://developer.humanitec.com/>).
* [`gke-temporary-credentials-runtime.yaml`](gke-temporary-credentials-runtime.yaml): uses temporary credentials defined via a Cloud Account. The Resource Id specified in the Matching Criteria is `k8s-cluster-runtime` and it ensures that this Definition will be matched to provision the `k8s-cluster` Resource co-provisioned by the GitOps cluster Resource Definition. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
  * This `runtime` Resource Definition can optionally use the [Humanitec Agent](https://developer.humanitec.com/integration-and-extensions/humanitec-agent/overview) to access runtime information on a private cluster. This requires the Agent to be configured for being able to access the cluster and the corresponding Agent Resource Definition (next item) being matched in the `agent_url` property. See the [documentation](https://developer.humanitec.com/integration-and-extensions/humanitec-agent/how-tos/deploy-to-a-private-cluster-using-the-humanitec-agent/) for details.
* [`gke-agent.yaml`](./gke-agent.yaml): defines the Resource for the [Humanitec Agent](https://developer.humanitec.com/integration-and-extensions/humanitec-agent/overview). Relevant only if the Agent is being used to access the runtime cluster, which is recommended and even required if the runtime cluster is not directly accessible for the Platform Orchestrator.
* [`custom-namespace.yaml`](./custom-namespace.yaml): shows how to use the Echo Driver to return the name of an externally managed namespace that must match the namespace where the GitOps Operator creates the resources. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
