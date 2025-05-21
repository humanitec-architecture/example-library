resource "humanitec_resource_definition" "secretstore-config" {
  driver_type = "humanitec/echo"
  id          = "secretstore-config"
  name        = "secretstore-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "project_id" = "my-gcp-project-id"
    })
  }
}

resource "humanitec_resource_definition_criteria" "secretstore-config_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.secretstore-config.id
  class                  = "secretstore"
  app_id                 = "my-secretstore-app"
}
