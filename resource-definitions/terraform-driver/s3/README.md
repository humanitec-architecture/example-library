Use the [Terraform Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform/) to provision [Amazon S3 bucket](https://docs.aws.amazon.com/s3) resources.

- [public-git-repo.tf](public-git-repo.tf): uses a publicly accessible Git repo to find the Terraform code.
- [private-git-repo.tf](private-git-repo.tf): uses a private Git repo requiring authentication to find the Terraform code.