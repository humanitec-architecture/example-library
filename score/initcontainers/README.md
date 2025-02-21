Define an [init container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) for your Workload.

This example shows how developers may define `initContainers` using a [Humanitec Score Extension file](https://developer.humanitec.com/score/score-extension-file/) and the [Pod feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humanitecpod). This feature lets you specify any part of the Kubernetes `PodSpec`, including `initContainers`.

To manage init containers centrally through the Platform Engineering team and shift the task away from developers, take a look at the [Resource Definition example on init containers](https://developer.humanitec.com/examples/resource-definitions/template-driver/initcontainers/).

Use this command to deploy the example:

```bash
humctl score deploy \
  --app ${HUMANITEC_APP} --env ${HUMANITEC_ENV} \
  --extensions humanitec.score.yaml
```