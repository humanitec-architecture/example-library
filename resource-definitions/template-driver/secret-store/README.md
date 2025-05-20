This example shows how you can create an Environment-local [Secret store](https://developer.humanitec.com/guides/platform-engineers/security/connect-secret-stores/overview/) definition with each Deployment.

The mechanism uses a Resource Definition of type [base-env](https://developer.humanitec.com/platform-orchestrator/reference/resource-types/#base-env) to create a `SecretStore` Custom Resource (CR) in the Kubernetes namespace of the target Environment.

You have a choice to make the `SecretStore` `name` either context-agnostic, i.e. static, or context-specific using [Placeholders](https://developer.humanitec.com/platform-orchestrator/reference/placeholders/). Note that secret references used for accessing secrets from that store [cannot currently use Placeholders as well](https://developer.humanitec.com/platform-orchestrator/security/secret-references/#limitations), so involved parties will have to follow an agreed on convention to use the same store names.

The example follows the recommended practice to source configuration values for the `SecretStore` object from a `config` Resource.

The secret store defined in the `base-env` may be used normally in [Secret references](https://developer.humanitec.com/platform-orchestrator/security/secret-references/) using the secret store ID specified in `metadata.name` of the `SecretStore` manifest.

> In edge cases, an Operator error may occur on the first deployment using this mechanism saying "secret store <name> is not found in application and operator system namespaces". This may be due to the timing of the `SecretStore` manifest creation and a Resource requiring it to be present, not reoccur for all subsequent deployments given the setup is otherwise correct.

Two Resource Definitions are provided:

- [`base-env-secretstore.yaml`](./base-env-secretstore.yaml): Defines the `base-env` creating the `SecretStore` CR in the target namespace of the Environment
- [`config-secretstore.yaml`](./config-secretstore.yaml): Defines the `config` Resource for providing parameters to the `base-env` to define the `SecretStore`
