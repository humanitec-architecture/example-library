resource "humanitec_resource_definition" "s3-concrete" {
  driver_type = "humanitec/echo"
  id          = "s3-concrete"
  name        = "s3-concrete"
  type        = "s3"
  driver_inputs = {
    values_string = jsonencode({
      "bucket" = "example-bucket"
    })
  }
}

resource "humanitec_resource_definition_criteria" "s3-concrete_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.s3-concrete.id
  app_id                 = "example-delegator"
  class                  = "concrete"
}
