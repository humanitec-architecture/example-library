# Credentials

## General credentials configuration

Different [Terraform providers](https://developer.hashicorp.com/terraform/language/providers) have different ways of being configured. Generally, there are 3 ways that providers can be configured:

- Directly using parameters on the provider. We call this "provider" credentials.
- Using a credentials file. The filename is supplied to the provider. We call this "file" credentials.
- Via environment variables that the provider reads. We call this "environment" credentials.


A powerful approach for working with different cloud accounts for the same resource definition is to reference the credentials from a `config` resource. By using matching criteria on the `config` resource, it is possible to specialize the account used in the terraform to different contexts. For example, there might be different AWS Accounts for `test` and `production` environments.  The same resource definition can be used to manage the terraform and 2 `config` resources can be created matching to the `staging` and `production` environments respectively.

In this set of examples, we provide two `config` Resource Definitions for AWS and GCP.

### AWS

- [Account config (`account-config-aws.yaml`)](./account-config-aws.yaml)
- [Provider Credentials (`aws-provider-credentials.yaml`)](./aws-provider-credentials.yaml)
- [Environment Credentials (`aws-environment-credentials.yaml`)](./aws-environment-credentials.yaml)

### GCP

- [Account config (`account-config-gcp.yaml`)](./account-config-gcp.yaml)
- [File Credentials (`gcp-file-credentials.yaml`)](./gcp-file-credentials.yaml)

## Dynamic credentials

Using a Cloud Account type that supports dynamic credentials, those credentials can be easily injected into a Resource Definition using the Terraform Driver. Use a `driver_account` referencing the Cloud Account in the Resource Definition, and access its the credentials through the supplied values as shown in the examples.

### AWS

- [S3 bucket (`s3-dynamic-credentials.yaml`)](./s3-dynamic-credentials.yaml)

### GCP

- [Cloud Storage bucket (`gcs-dynamic-credentials.yaml`)](./gcs-dynamic-credentials.yaml)

### Azure

- [Blob Storage container (`azure-blob-storage-dynamic-credentials.yaml`)](./azure-blob-storage-dynamic-credentials.yaml)