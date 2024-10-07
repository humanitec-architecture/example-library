resource "humanitec_resource_definition" "example-config-one" {
  driver_type = "humanitec/echo"
  id          = "example-config-one"
  name        = "example-config-one"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "name" = "name-01"
    })
  }
}

resource "humanitec_resource_definition_criteria" "example-config-one_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.example-config-one.id
  class                  = "one"
  res_id                 = "example"
  app_id                 = "example-propagate-class"
}
