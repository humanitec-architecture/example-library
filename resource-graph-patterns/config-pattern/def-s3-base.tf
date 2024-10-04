resource "humanitec_resource_definition" "config-pattern-example-s3-base" {
  driver_type = "humanitec/echo"
  id          = "config-pattern-example-s3-base"
  name        = "config-pattern-example-s3-base"
  type        = "s3"
  driver_inputs = {
    values_string = jsonencode({
      "region" = "$${resources.config.outputs.region}"
      "bucket" = "$${resources.config.outputs.bucket_name}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "config-pattern-example-s3-base_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.config-pattern-example-s3-base.id
  app_id                 = "example-config-pattern"
}
