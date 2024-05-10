## Using dynamic credentials

This section contains example Resource Definitions using the [Humanitec Agent](https://developer.humanitec.com/integration-and-extensions/humanitec-agent/overview/) for connecting to GKE clusters.

* [gke-agent.yaml](gke-agent.yaml): uses a Cloud Account as well as the Humanitec Agent to access this private cluster. This format is for use with the [Humanitec CLI](https://developer.humanitec.com/platform-orchestrator/cli/).
* [gke-agent.tf](gke-agent.tf): uses a Cloud Account as well as the Humanitec Agent to access this private cluster. This format is for use with the [Humanitec Terraform provider](https://registry.terraform.io/providers/humanitec/humanitec)