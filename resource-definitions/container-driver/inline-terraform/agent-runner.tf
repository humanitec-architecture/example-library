resource "humanitec_resource_definition" "agent-runner" {
  driver_type = "humanitec/agent"
  id             = "agent-runner"
  name           = "agent-runner"
  type           = "agent"
  driver_inputs  = {
    values_string  = jsonencode({
      "id" = "my-agent"
    })
  }
}

resource "humanitec_resource_definition_criteria" "agent-runner_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.agent-runner.id 
  env_type = "development"
  class = "runner"
}
