## Score examples

The following examples show how to use [Score](https://developer.humanitec.com/score/overview/) to deploy Applications and infrastructure configurations.

Each example highlights a particular use case and shows either a Score file (`score.yaml`), a Score extension file (`humanitec.score.yaml`), or both.

To use any particular example, use the [`score-humanitec` CLI](https://developer.humanitec.com/score/installation/) and execute this command:

```bash
score-humanitec delta \
              -f score.yaml \
              --extensions humanitec.score.yaml
              --app ${APP_ID} \
              --env ${ENV_ID} \
              --org ${HUMANITEC_ORG} \
              --token ${HUMANITEC_TOKEN} \
              --deploy
```

Usage notes:
- If both files are shown, they must be used in conjunction.
- If no Score file or no Score extension file is shown, no particular configuration is required through that file.
- A Score extension file alone is never sufficient to perform a Workload Deployment. If no Score file is shown, you may choose one of your own, e.g. the [Hello World](https://developer.humanitec.com/score/getting-started/hello-world/) example.
- A Score extension file is picked up automatically if present in the same directory and named `humanitec.score.yaml`.