resource "humanitec_resource_definition" "config-pattern-example-config-developer-overrides" {
  driver_type = "humanitec/echo"
  id          = "config-pattern-example-config-developer-overrides"
  name        = "config-pattern-example-config-developer-overrides"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "prefix" = "overridden-"
    })
  }
}

resource "humanitec_resource_definition_criteria" "config-pattern-example-config-developer-overrides_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.config-pattern-example-config-developer-overrides.id
  app_id                 = "example-config-pattern"
  class                  = "developer-overrides"
}
