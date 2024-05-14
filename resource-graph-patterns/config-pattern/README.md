# Config Pattern

This example demonstrates how `config` resources can be used to parameterize general purpose resource definitions. The `config` resource can be used to parameterize a Resource Definition for different contexts such as environment type and even be used by development teams to further specialize a resource for their purpose.


## How the example works

This example is made up of:

* A single `s3` resource definition. (Implemented using the [Echo driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/echo/) for simplicity for this example)
* A `config` resource that provides default configuration as specified by the platform team.
* A `config` resource that can be used by developers to override some configuration values.

The [Resource Graph](https://developer.humanitec.com/platform-orchestrator/resources/resource-graph) for production with developer overrides would look like:

```mermaid
flowchart LR
    WL[Workload] -->|score resource dependency| S3(type: s3, id: s3-bucket, class: default)
    S3 --> CONF_S3(type: config, id: s3-bucket, class: default)
    CONF_S3 --> CONF_S3_DEV_OVERRIDE(type: config, id: s3-bucket, class: developer-overrides)

```

The example demonstrates how:
- different configurations can be used in different environments while using the same Terraform Resource Definition
- developers can optionally provide overrides that can be controlled by the platform team.

There are 3 resource definitions:

1. The `s3` Resource Definition [`s3-base.yaml`](./resource-definitions/s3-base.yaml) defines the underlying "base" resource. In this case it is very simple - implemented using the Echo Driver. It takes 2 parameters - `region` and `bucket` - returning both of these.

2. The first `config` Resource Definition [`config-platform-defaults.yaml`](./resource-definitions/config-platform-defaults.yaml) does two things:

   - Provide default configuration values supplied by the platform team.
   - Reference the overrides that developers can supply via their own `config` Resource Definition.

   These config also provide guardrails in that only certain values can be overridden. In this example, developers can override the `prefix` and the `name` properties but not `tags` or `region`.

3. The last `config` Resource Definition [`config-developer-overrides.yaml`](./resource-definitions/config-developer-overrides.yaml) allows developers to provide their overrides that can tune the resource that they request.

In practice, you may choose to maintain the Resource Definitions for the platform team and the developers in different git repositories to separate out access permissions.

## Run the demo

### Prerequisites

See the [prerequisites section](../README.md#prerequisites) in the README at the root of this section.

In addition, the environment variable `HUMANITEC_APP` should be set to `example-config-pattern`.

### Cost

This example will result in one Pod being deployed.

### Deploy the example

1. Create a new app:

   ```bash
   humctl create app "${HUMANITEC_APP}"
   ```

2. Register the Resource Definitions:

   ```bash
   humctl apply -f ./resource-definitions
   ```

3. Deploy the Score workload:

   ```bash
   humctl score deploy
   ```

4. Inspect the effective environment variables of your workload:

- Open the portal at https://app.humanitec.io/orgs/${HUMANITEC_ORG}/apps/example-config-pattern/envs/development
- Select the `example-config-pattern-workload` and inspect the log output of the `busybox` container.
- Check the values of the `BUCKET_NAME` and or `BUCKET_REGION` variables.

## Explore the example

1. Change the `name` and or `prefix` properties in [`config-developer-overrides.yaml`](./resource-definitions/config-developer-overrides.yaml). Try adding `region`.

2. Redeploy:

   ```bash
   humctl score deploy
   ```

3. Observe if the `BUCKET_NAME` and or `BUCKET_REGION` variables have changed.

### Clean up the example

1. Delete the Application:

   ```bash
   humctl delete app "${HUMANITEC_APP}"
   ```

2. Delete the Resource Definitions:

   ```bash
   humctl delete -f ./resource-definitions
   ```
