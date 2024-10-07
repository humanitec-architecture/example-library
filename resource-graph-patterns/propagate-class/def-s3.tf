resource "humanitec_resource_definition" "example-s3" {
  driver_type = "humanitec/echo"
  id          = "example-s3"
  name        = "example-s3"
  type        = "s3"
  driver_inputs = {
    values_string = jsonencode({
      "bucket" = "$${resources.config#example.outputs.name}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "example-s3_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.example-s3.id
  class                  = "one"
  app_id                 = "example-propagate-class"
}

resource "humanitec_resource_definition_criteria" "example-s3_criteria_1" {
  resource_definition_id = resource.humanitec_resource_definition.example-s3.id
  class                  = "two"
  app_id                 = "example-propagate-class"
}
