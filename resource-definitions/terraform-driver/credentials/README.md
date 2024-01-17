# Credentials

Different providers have different ways of being configured. Generally, there are 3 ways that providers can be configured:

- Directly using parameters on the provider. We call this "provider" credentials
- Using a credentials file. The filename is supplied to the provider. We call this "file" credentials.
- Via environment variables that the provider reads. We call this "environment" credentials.

> **NOTE**: At this time, the Humanitec Terraform driver only supports "provider" and "file" credentials.

The general approach for working with providers is to reference the credentials from a `config` resource.  In this set of examples, we provide 2 config resources. An [AWS](account-config-aws.yaml) and a [GCP](account-config-gcp.yaml) account config resource definition.

## AWS

- [Provider Credentials](aws-provider-credentials.yaml)
- [File Credentials](aws-file-credentials.yaml)

## GCP

- [File Credentials](gcp-file-credentials.yaml)