This example shows how to deploy multiple workloads within one deployment.

Doing so requires a separate Score file per workload ([`score.example-service.yaml`](score.example-service.yaml) and [`score.another-service.yaml`](score.another-service.yaml)). The example also uses a Score extension file ([`score.humanitec.yaml`](score.humanitec.yaml)) to apply some common settings to both workloads.

The file [`deploy-config.yaml`](deploy-config.yaml) wraps all those files into a deploy configuration which can be passed in to `humctl` using the `--deploy-config` flag. See the [CLI documentation](https://developer.humanitec.com/platform-orchestrator/reference/cli-references/#score-integration) for details.
