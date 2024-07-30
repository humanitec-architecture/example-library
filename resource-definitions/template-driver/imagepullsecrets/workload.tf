resource "humanitec_resource_definition" "custom-workload" {
  driver_type = "humanitec/template"
  id          = "custom-workload"
  name        = "custom-workload"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = "update:\n  - op: add\n    path: /spec/imagePullSecrets\n    value:\n      - name: $${resources['config.default#regcred'].outputs.secret_name}"
      }
    })
  }
}

