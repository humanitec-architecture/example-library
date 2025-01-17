The [Container Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container/) executes a container supplied as input as part of a Kubernetes Job execution in a target Kubernetes cluster.

The example in this section shows:

* How to use the official Hashicorp maintained Terraform image with the container driver
* How to inject the cloud account credentials into the IaC code running in the container via the [credentials_config](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container#credentials_config-object) object.

The example is made up out of these files:
* [s3.yaml](s3.yaml): alongside the terraform code, a Shell script called `run.sh` is also included. This invokes the `terraform` command in the image.

This example requires:
- A managed cluster - one of AKS, EKS or GKE
- An agent configured to match res_id `runner`

**NOTE**

Due to the [Hashicorp License change for Terraform](https://www.hashicorp.com/blog/hashicorp-adopts-business-source-license) Humanitec is unable to provide examples of using the Container Driver with versions of the `hashicorp/terraform` image higher than `1.5.7` which is the last image released under the MPL 2.0.