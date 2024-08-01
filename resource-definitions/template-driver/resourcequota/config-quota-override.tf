resource "humanitec_resource_definition" "quota-config-override" {
  driver_type = "humanitec/echo"
  id          = "quota-config-override"
  name        = "quota-config-override"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "limits-cpu"    = "750m"
      "limits-memory" = "750Mi"
    })
  }
}

resource "humanitec_resource_definition_criteria" "quota-config-override_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.quota-config-override.id
  res_id                 = "quota"
  app_id                 = "my-app"
}
