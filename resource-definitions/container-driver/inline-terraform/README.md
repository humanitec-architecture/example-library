The [Container Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container/) executes a container supplied as input as part of a Kubernetes Job execution in a target Kubernetes cluster.

The example in this section shows:

* How to reference a `config` Resource Definition to provide the data needed to create a Kubernetes Job in the desired [cluster](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container#cluster-object).
* How to reference a `config` Resource Definition to create the [job](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container#job-object) with the proper configuration.
* How to make the Kubernetes Job able to [pull an image from a private registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry).
* How to inject the cloud account credentials into the IaC code running in the container via the [credentials_config](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container#credentials_config-object) object.

The example is made up out of these files:
* [k8s-cluster-runner-config.yaml](k8s-cluster-runner-config.yaml): provides a connection to a [GKE cluster](https://developer.humanitec.com/integration-and-extensions/drivers/k8-drivers/gke-cluster/).
* [agent-runner.yaml](agent-runner.yaml): provides the configuration to access a private cluster via the Humanitec Agent.
* [s3.yaml](s3.yaml): in addition to referencing the `config` Resource Definition, it defines the Terraform scripts to run to provision an S3 bucket whose name is produced appending a random postfix to the application and the environment name. The supplied scripts provide an AWS S3 bucket as place where to store the resource state.
