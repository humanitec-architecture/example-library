resource "humanitec_resource_definition" "tf-backend-config" {
  driver_type    = "humanitec/echo"
  id             = "tf-backend-config"
  name           = "tf-backend-config"
  type           = "config"
  driver_account = "aws-ref-arch"
  driver_inputs = {
    values_string = jsonencode({
      "bucket" = "my-terraform-state-bucket"
      "prefix" = "tf-state/"
      "region" = "us-east-1"
    })
  }
}

resource "humanitec_resource_definition_criteria" "tf-backend-config_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.tf-backend-config.id
  res_id                 = "tf-backend"
}
