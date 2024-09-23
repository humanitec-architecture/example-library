## Score examples

The following examples show how to use [Score](https://developer.humanitec.com/score/overview/) to deploy Applications and infrastructure configurations.

Each example highlights a particular use case and shows either a Score file (`score.yaml`), a Score extension file (`humanitec.score.yaml`), or both.

To use any particular example, use the [`humctl` CLI](https://developer.humanitec.com/platform-orchestrator/cli/) and execute this command:

```bash
humctl score deploy \
              -f score.yaml \
              --extensions humanitec.score.yaml
              --app ${APP_ID} \
              --env ${ENV_ID} \
              --org ${HUMANITEC_ORG} \
              --token ${HUMANITEC_TOKEN} \
```

Usage notes:
- If both files are shown, they must be used in conjunction.
- If no Score file or no Score extension file is shown, no particular configuration is required through that file.
- A Score extension file alone is never sufficient to perform a Workload Deployment. If no Score file is shown, you may choose one of your own, e.g. the [Hello World](https://developer.humanitec.com/score/getting-started/hello-world/) example.
- A Score file is picked up automatically if present in the same directory and named `score.yaml`.
- A Score extension file is not picked up automatically, it must be spefified using the `--extensions` flag.
- Make sure to use the proper types in your Score and Score extensions files to prevent deployment errors. They will be passed through as-is. E.g. when setting the `boolean` value for the `setHostnameAsFQDN` property in the [PodSpec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#PodSpec), configure it in the extension file like this:

```yaml
apiVersion: humanitec.org/v1b1
spec:
  pod:
    setHostnameAsFQDN: true # Not "true"
```