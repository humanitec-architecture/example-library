resource "humanitec_resource_definition" "gke-agent" {
  driver_type = "humanitec/agent"
  id          = "gke-agent"
  name        = "gke-agent"
  type        = "agent"
  driver_inputs = {
    values_string = jsonencode({
      "id" = "gke-agent"
    })
  }
}

resource "humanitec_resource_definition_criteria" "gke-agent_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.gke-agent.id
  env_type               = "development"
  res_id                 = "agent"
}
