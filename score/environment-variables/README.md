Define environment variables for a container. There are two ways to configure them.

1. Via the Score file
    
    The Score specification supports [placeholder references](https://docs.score.dev/docs/score-specification/score-spec-reference/#placeholder-references) to the Workload metadata or Resources named in the Score file. The syntax and supported values are different in Score compared to the Platform Orchestrator, and the Platform Orchestrator will automatically convert Score references to native [placeholders](https://developer.humanitec.com/platform-orchestrator/reference/placeholders/) when deploying a Score file. Variables will be mapped into the container through a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) or [Secret](https://kubernetes.io/docs/concepts/configuration/secret/).

    The Platform Orchestrator supports an `environment` resource for accessing the shared values in the application environment:

    ```yaml
    apiVersion: score.dev/v1b1
    metadata:
      name: example
    containers:
      main:
        image: example
        variables:
          KEY_ONE: hello-world
          KEY_TWO: ${resources.env.VALUE}
    resources:
      env:
        type: environment
    ```

2. Via the Score extensions file

    Score extensions files contain Platform Orchestrator specific content allowing the workload profile or deployment options to be configured along with overrides to the resulting workloads. The Score extensions file supports the use of Score [placeholder references](https://docs.score.dev/docs/score-specification/score-spec-reference/#placeholder-references) and native [placeholders](https://developer.humanitec.com/platform-orchestrator/reference/placeholders/) when escaped with a `$`.

    ```yaml
    apiVersion: humanitec.org/v1b1
    spec:
      containers:
        main:
          variables:
            KEY_THREE: $${values.VALUE}
            KEY_FOUR: goodbye
    ```

{{% example-file filename="score.yaml" dir="score/environment-variables" githubUrl="https://github.com/humanitec-architecture/example-library/blob/main" %}}
