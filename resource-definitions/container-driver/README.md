## Resource Definitions using the Container Driver

This section contains example Resource Definitions using the [Container Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container).

The requirements to make these Resource Definitions work with the Orchestrator are:

* The image supplied in the Container Driver Definitions in `values.job.image` should adhere to the [interface between Driver and Runner Image](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/generic-async/#contract-between-container-driver-and-runner-image).
* The cluster chosen to run the Kubernetes Job should be [properly configured](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container/#cluster-object).
