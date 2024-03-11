Add files to Containers.

Refer to the [files feature](https://developer.humanitec.com/integration-and-extensions/workload-profiles/features/#humaniteccontainers---files) for configuration details.

The examples show these variations to provide file content:

* [score.yaml](./score.yaml): Base approach supplying the file contents as a multiline string. This approach creates the same file content across all environments.
* [score-shared-values.yaml](./score-shared-values.yaml): (Recommended) Supplying the file contents via a [Shared Value](https://developer.humanitec.com/platform-orchestrator/working-with/shared-values/) via the `environment` resource which is available as part of the [Score specification](https://docs.score.dev/docs/environment-variables/environment-variables-humanitec/). Since Shared Values may optionally be overridden on an Environment level, this approach lets you inject environment-specific configuration managed through the Platform Orchestrator.
* [score-local-file-source.yaml](./score-local-file-source.yaml): Supplying the file contents via a file available locally which is read at Score deployment time, i.e. when executing `score-humanitec delta --deploy`.