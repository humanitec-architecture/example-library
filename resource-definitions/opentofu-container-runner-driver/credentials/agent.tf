resource "humanitec_resource_definition" "agent-opentofu-container-runner" {
  driver_type = "humanitec/agent"
  id          = "agent-opentofu-container-runner"
  name        = "agent-opentofu-container-runner"
  type        = "agent"
  driver_inputs = {
    values_string = jsonencode({
      "id" = "my-agent"
    })
  }
}

resource "humanitec_resource_definition_criteria" "agent-opentofu-container-runner_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.agent-opentofu-container-runner.id
  env_type               = "development"
}
