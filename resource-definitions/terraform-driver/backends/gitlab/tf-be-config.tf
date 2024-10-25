resource "humanitec_resource_definition" "example-terraform-gitlab-backend-config" {
  driver_type = "humanitec/template"
  id          = "example-terraform-gitlab-backend-config"
  name        = "example-terraform-gitlab-backend-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "gitlab_project_id" = ""
      "state_name"        = "$${context.app.id}_$${context.env.id}_$${context.res.id}"
      "templates" = {
        "init"    = "address: https://gitlab.com/api/v4/projects/{{ .driver.values.gitlab_project_id }}/terraform/state/{{ .driver.values.state_name | replace \".\" \"_\" }}\n"
        "outputs" = <<END_OF_TEXT
# Useful for debugging to output the address as an output
address: {{ .init.address }}
END_OF_TEXT
        "secrets" = <<END_OF_TEXT
backend_tf: |
  terraform {
    # https://developer.hashicorp.com/terraform/language/v1.5.x/settings/backends/configuration
    # https://developer.hashicorp.com/terraform/language/v1.5.x/settings/backends/http
    backend "http" {
      address = "{{ .init.address }}"
      lock_address = "{{ .init.address }}/lock"
      lock_method = "POST"
      unlock_address = "{{ .init.address }}/lock"
      unlock_method = "DELETE"
      username = "{{ .driver.secrets.username }}"
      password = "{{ .driver.secrets.password }}"
      retry_wait_min = 5
    }
  }
END_OF_TEXT
      }
    })
    secret_refs = jsonencode({
      "username" = {
        "store" = null
        "ref"   = null
      }
      "password" = {
        "store" = null
        "ref"   = null
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "example-terraform-gitlab-backend-config_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.example-terraform-gitlab-backend-config.id
  class                  = "tf-runner"
}
