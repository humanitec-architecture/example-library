resource "humanitec_resource_definition" "custom-workload" {
  driver_type = "humanitec/template"
  id          = "custom-workload"
  name        = "custom-workload"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update:
  - op: add
    path: /spec/imagePullSecrets
    value:
      - name: $${resources['config.default#regcred'].outputs.secret_name}
END_OF_TEXT
      }
    })
  }
}

