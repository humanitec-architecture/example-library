When the Platform Orchestrator deploys changes into an Environment, the Deployment status indicates whether it successfully provisioned associated resources and configured the Workloads. It does not necessarily imply that the Workloads are healthy or that the desired functionality is available to end users. The Pipeline will also be successful in scenario where the Workload will never be `Ready`, for example when the container image doesn't exist (`ImagePullBackOff`), or when an admission controller is blocking the deployment in the Kubernetes cluster, etc.


Humanitec Pipelines can be used to wait for the readiness of the Worklaods deployed in Kubernetes, and fail the Pipeline if the previous step timed out.

This Pipeline definition shows how to accomplish this.

Note: the `Deployment status` on the Deployment in Humanitec will still be `Successful`.

When the Pipeline is in `Failed` status, `humctl score deploy --wait` or `humctl deploy --wait` will fail. Then to get the associated errors, you can catch the details of errors by combining the result of:
- `humctl get deployment-error`
- `humctl api get /orgs/${HUMANITEC_ORG}/apps/${APP}/envs/${ENV}/runtime`
