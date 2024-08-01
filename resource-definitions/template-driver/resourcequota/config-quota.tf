resource "humanitec_resource_definition" "quota-config" {
  driver_type = "humanitec/echo"
  id          = "quota-config"
  name        = "quota-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "limits-cpu"    = "500m"
      "limits-memory" = "500Mi"
    })
  }
}

resource "humanitec_resource_definition_criteria" "quota-config_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.quota-config.id
  res_id                 = "quota"
}
