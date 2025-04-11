This example shows how to inject secret values into a container run by the [Container Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/container/) from a downstream Resource in the Graph.

The same pattern applies to any Virtual Driver that wraps the Container Driver.

The example consists of these files:

- [mysql.yaml](./mysql.yaml): A Resource Definition of type `mysql` using the Container Driver. It uses an external Git repository to retrieve some IaC code, e.g. Terraform, for execution. The key element for this example is the setting of environment variables for the Container Driver runner in this section. The variables values themselves are obtained as secret outputs from a `mysql-instance` Resource:

```yaml
entity:
  driver_inputs:
    secret_refs:
      job:
        variables:
          TF_VAR_...
```

- [mysql-instance.yaml](./mysql-instance.yaml): A Resource Definition of type `mysql-instance` using the Echo Driver, so the Orchestrator is not managing the instance but just providing access data to the upstream `mysql` Resource.
- [runner-config.yaml](./runner-config.yaml): Externalized configuration values for the Container Driver in a `config` Resource Definition