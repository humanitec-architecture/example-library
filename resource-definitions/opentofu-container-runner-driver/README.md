## Resource Definitions using the OpenTofu Container Runner Driver

The [OpenTofu Container Runner Driver Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform-and-opentofu-container-runner/) provides an easy way to execute [OpenTofu](https://opentofu.org/) code.

This driver handles the runner outputs to be compliant with the [interface expeceted by the Orchestrator](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container/#contract-between-container-driver-and-runner-image).

The example in this section shows:

* How to build the `config` Resource Definition needed by the Resource Definition based on the [OpenTofu Container Runner Driver Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform-and-opentofu-container-runner/). This `config` Definition provides the data needed to create a Kubernetes Job in the desired [cluster](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container/#cluster-object).
* How to make the Kubernetes Job able to [pull an image from a private registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry).
* How to inject the cloud account credentials into the IaC code running in the container via the [credentials_config](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform-and-opentofu-container-runner#credentials_config-object) object.
* How to fetch the OpenTofu scripts from a private Repository, via [non-secret](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform-and-opentofu-container-runner/#source-object) and [secret](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform-and-opentofu-container-runner#source-object-1) fields.
* How to inject the OpenTofu scripts as an inline file of the Resource Definition, via [files](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform-and-opentofu-container-runner#inputs).

The example is made up out of these files:

* [k8s-cluster-opentofu-container-runner-config.yaml](k8s-cluster-opentofu-container-runner-config.yaml): provides a connection to a [GKE cluster](https://developer.humanitec.com/integration-and-extensions/drivers/k8-drivers/gke-cluster/).
* [agent.yaml](agent.yaml): provides the configuration to access a private cluster via the Humanitec Agent. It is needed by the `config` Resource.
* [s3.yaml](s3.yaml): in addition to referencing the `config` Resource Definition, it defines how to fetch the Terraform scripts from a private Github Repository to provision an S3 bucket. This also provides via file an AWS S3 bucket as place where to store the resource state.
