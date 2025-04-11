## Terraform Container Runner Driver Examples

The [Terraform Container Runner Driver Driver](https://developer.humanitec.com/integration-and-extensions/drivers/generic-drivers/terraform-and-opentofu-container-runner/) provides an easy way to execute [Terraform](https://www.terraform.io/) code.

The same definitions shown in the [OpenTofu Container Runner Driver](https://developer.humanitec.com/examples/resource-definitions/opentofu-container-runner-driver) section can be used, please take care of updating:

* The `driver_type` field in the `s3.yaml` Resource Definition to be `humanitec/terraform-container-runner`.
* The `res_id` value in the `config` Resource Definition to be `terraform-container-runner`.
