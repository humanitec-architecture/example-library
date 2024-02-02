# Dynamic Credentials

Using a Cloud Account type that supports dynamic credentials, those credentials can be easily injected into a Resource Definition using the Terraform Driver. Use a `driver_account` referencing the Cloud Account in the Resource Definition, and access its the credentials through the supplied values as shown in the examples.

## AWS

- [S3 bucket (`s3-dynamic-credentials.yaml`)](./s3-dynamic-credentials.yaml)