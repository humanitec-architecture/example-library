# Backends

When a `terraform apply` is executed, data and metadata is generated that must be stored to be able to keep track of the resources that have been created. For example, the ID of an S3 bucket might be generated. This ID is needed in order to update or destroy the bucket on future invocations. This data is stored in a [Terraform State file](https://developer.hashicorp.com/terraform/language/v1.5.x/state). The state file should be considered _sensitive data_ as it can contain secrets such as credentials or keys.

Terraform provides various ways storing the state file in different places. These are called [Backends](https://developer.hashicorp.com/terraform/language/v1.5.x/settings/backends/configuration).

_Humanitec recommends that you configure a backend for all Resource Definitions using the Terraform Driver. That way you maintain control over the state file and any sensitive data it may contain._

## Configuring a backend

### Terraform block

Backend configuration can be defined in the [`terraform` block](https://developer.hashicorp.com/terraform/language/v1.5.x/settings). Terraform imposes limitations on the `terraform` block. For example, Terraform variables cannot be used to parameterize the `terraform` block.  This means that the terraform block must be generated ahead of time.

Backends can be configured via a `backend` block inside the `terraform` block. An example block would be:

```
terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}
```


### Unique state key

The key used to identify the terraform state needs to be unique to all *instances* of a resource being created. A resource is uniquely described by its context. That is the application ID, environment ID, Type and Class of the resource and the Resource ID.

Here is an example string of placeholders that will uniquely define a resource.

```
${context.app.id}_${context.env.id}_${context.res.type}_${context.res.class}_${context.res.id}
```

A less descriptive, but equally unique key would be the Globally Unique RESource ID (GUResID). This is available for the current resource via this placeholder:

```
${context.res.guresid}
```

### Credentials

State files often contain sensitive data. Therefore they should be stored on backend that support authorization. This means that the backend should be configured with credentials in Terraform.

There are 2 broad types of credentials that could be used:

- Temporary credentials
- Long lived credentials

The Platform Orchestrator supports Temporary Credentials via [Cloud Accounts](https://developer.humanitec.com/platform-orchestrator/security/cloud-accounts/overview/). All backends can be configured via environment variables, so it is recommended to use the [`credentials_config` object](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/#inputs) to specify credentials via the appropriate environment variable for the backend.

For Long lived credentials, it is recommended to store the credentials in a config resource definition and inject them using a placeholder.

# Examples

The following examples of configuring backends are provided:

- [S3 backend using temporary credentials](./s3/README.md)
- [GitLab HTTP backed using long lived credentials](./gitlab/README.md)
