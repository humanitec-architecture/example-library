resource "humanitec_resource_definition" "example-config-two" {
  driver_type = "humanitec/echo"
  id          = "example-config-two"
  name        = "example-config-two"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "name" = "name-02"
    })
  }
}

resource "humanitec_resource_definition_criteria" "example-config-two_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.example-config-two.id
  class                  = "two"
  res_id                 = "example"
  app_id                 = "example-propagate-class"
}
