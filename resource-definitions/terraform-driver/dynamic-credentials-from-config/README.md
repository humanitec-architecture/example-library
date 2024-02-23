# Credentials

Different [Terraform providers](https://developer.hashicorp.com/terraform/language/providers) have different ways of being configured. Generally, there are 3 ways that providers can be configured:

- Directly using parameters on the provider. We call this "provider" credentials.
- Using a credentials file. The filename is supplied to the provider. We call this "file" credentials.
- Via environment variables that the provider reads. We call this "environment" credentials.

> **NOTE**: At this time, the [Humanitec Terraform driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/) only supports "provider" and "file" credentials.

The general approach for working with providers is to reference the account from a `config` resource in `driver_account` field.  In this set of examples, we provide two `config` Resource Definitions for AWS and GCP.

## AWS

- [Account config (`account-config-aws.yaml`)](./account-config-aws.yaml)
- [File Credentials (`aws-file-credentials.yaml`)](./aws-provider-credentials.yaml)
- [Provider Credentials (`aws-provider-credentials.yaml`)](./aws-file-credentials.yaml)

## GCP

- [Account config (`account-config-gcp.yaml`)](./account-config-gcp.yaml)
- [File Credentials (`gcp-file-credentials.yaml`)](./gcp-file-credentials.yaml)