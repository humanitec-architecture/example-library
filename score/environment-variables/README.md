Define environment variables for a container. There are two ways to configure them.

1. Via the Score file
    
    This definition supports [placeholders](https://developer.humanitec.com/platform-orchestrator/reference/placeholders/). By default, variables will be visible in the Platform Orchestrator UI. Variables will be mapped into the container through a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) or [Secret](https://kubernetes.io/docs/concepts/configuration/secret/).

2. Via the Score extension file

    This definition does not support [placeholders](https://developer.humanitec.com/platform-orchestrator/reference/placeholders/). By default, variables will not be visible in the Platform Orchestrator UI. Variables will be mapped into the container as part of the container specification.