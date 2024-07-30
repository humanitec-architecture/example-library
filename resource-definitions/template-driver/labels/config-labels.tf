resource "humanitec_resource_definition" "app-config" {
  driver_type = "humanitec/template"
  id             = "app-config"
  name           = "app-config"
  type           = "config"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "outputs" = "cost_center_id: my-example-id\n"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "app-config_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.app-config.id 
  res_id = "app-config"
}
