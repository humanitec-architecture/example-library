resource "humanitec_resource_definition" "config-opentofu-container-runner" {
  driver_type = "humanitec/template"
  id          = "config-opentofu-container-runner"
  name        = "Config For OpenTofu Container Runner Driver"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = {
          "cluster" = {
            "account" = "myOrg/myAccount"
            "cluster" = {
              "name"         = "my-eks-cluster"
              "region"       = "eu-north-1"
              "cluster_type" = "eks"
              "loadbalancer" = "10.10.10.10"
            }
          }
          "skip_permission_checks" = false
        }
        "secrets" = "agent_url: {{ .driver.secrets.agent_url }}\n"
      }
    })
    secrets_string = jsonencode({
      "agent_url" = "$${resources.agent.outputs.url}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "config-opentofu-container-runner_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.config-opentofu-container-runner.id
  env_type               = "development"
  res_id                 = "opentofu-container-runner"
}
