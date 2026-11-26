## Resource Definitions using the Container (builtin) Driver

This section contains example Resource Definitions using the [Container (builtin) Driver](https://developer.humanitec.com/platform-orchestrator/docs/integration-and-extensions/drivers/container-builtin/) (`humanitec/container-builtin`).

The Container (builtin) Driver is built into the [Humanitec Operator](https://developer.humanitec.com/platform-orchestrator/docs/integration-and-extensions/humanitec-operator/overview/), so it does not need an outgoing connection to the Orchestrator SaaS. For each Resource using it, the Operator runs the image supplied in `values.job.image` as a Kubernetes Job. By default, the Job runs in the same cluster as the Operator.

The image is a runner that follows a small [contract](https://developer.humanitec.com/platform-orchestrator/docs/integration-and-extensions/drivers/container-builtin/#contract-between-container-driver-and-runner-image) with the Driver, based on environment variables and files:

| Env var | Meaning |
| --- | --- |
| `ACTION` | `create` or `destroy`. |
| `SCRIPTS_DIRECTORY` | The shared directory, set to `values.job.shared_directory`. The runner executes its command there. |
| `RESOURCE_INPUTS_FILE` | A file holding the Resource inputs as a JSON object. |
| `OUTPUTS_FILE` | Where the runner writes the non-secret outputs, as a JSON object. |
| `SECRET_OUTPUTS_FILE` | Where the runner writes the secret outputs, as a JSON object. |
| `ERROR_FILE` | Where the runner writes an error message before exiting with a non-zero code. |

The Orchestrator polls the Job until it finishes, then reads the outputs, or the error, from these files.

The requirements to make these Resource Definitions work with the Orchestrator are:

* The Humanitec Operator, version `0.28.2` or later, installed in the target cluster.
* A namespace and a service account for the Kubernetes Job, set in `values.job.namespace` and `values.job.service_account`.
* A runner image that adheres to the contract above.
