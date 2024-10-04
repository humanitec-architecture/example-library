resource "humanitec_resource_definition" "example-config-name-id" {
  driver_type = "humanitec/template"
  id          = "example-config-name-id"
  name        = "example-config-name-id"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "res_id" = "$${context.res.id}"
      "app_id" = "$${context.app.id}"
      "templates" = {
        "init"    = "workload_id: {{ .driver.values.res_id | splitList \".\" | last }}\n"
        "outputs" = <<END_OF_TEXT
role_arn: "arn:aws:iam::123456789012:role/{{ .driver.values.app_id }}/sa-role-{{ .init.workload_id }}"
sa_name: {{ .init.workload_id }}-sa
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "example-config-name-id_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.example-config-name-id.id
  class                  = "sa-name-role-id"
  app_id                 = "example-break-a-loop-additional-resource"
}
