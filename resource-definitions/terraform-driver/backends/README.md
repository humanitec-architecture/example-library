# Backends

Humanitec manages the state file for the `local` backend. This is the backend that is used if no backend is specified.

In order to manage your own state, you will need to define your own backend. We recommend that teh backend configuration is defined in the `script` part of the resource definition - i.e. as an `override.tf` file. This allows the backend to be tuned per resource instance.

In order to centralize configuration, it is also recommended to create a `config` resource that can be used to centrally manage the backend configuration.

In this example, there are 2 `config` resources defined:

- [`backend-config.yaml`](./backend-config.yaml) which provides shared backend configuration that can be used across resource definitions.
- [`account-config-aws.yaml`](./account-config-aws.yaml) which provides credentials used by the provider.

The example resource definition [`s3-backend.yaml`](./s3-backend.yaml) does the following:

- Configures a backend using the [`backend-config.yaml`](./backend-config.yaml)
- Configures the provider using a different set of credentials from [`account-config-aws.yaml`](./account-config-aws.yaml)
- Provision an s3 bucket.