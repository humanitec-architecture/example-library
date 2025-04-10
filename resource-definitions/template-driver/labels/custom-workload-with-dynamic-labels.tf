resource "humanitec_resource_definition" "custom-workload-with-label" {
  driver_type = "humanitec/template"
  id          = "custom-workload-with-label"
  name        = "custom-workload-with-label"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update:
  - op: add
    path: /spec/deployment/labels
    value:
      {{- range $key, $val := .resource.spec.deployment.labels }}
      {{ $key }}: {{ $val | quote }}
      {{- end }}
      env_id: $${context.env.id}
      cost_center_id: $${resources['config.default#app-config'].outputs.cost_center_id}
  - op: add
    path: /spec/pod/labels
    value:
      {{- range $key, $val := .resource.spec.pod.labels }}
      {{ $key }}: {{ $val | quote }}
      {{- end }}
  # If the Score file also defines a service, add labels to the service object
  {{- if .resource.spec.service }}
  - op: add
    path: /spec/service/labels
    value:
      {{- range $key, $val := .resource.spec.service.labels }}
      {{ $key }}: {{ $val | quote }}
      {{- end }}
      env_id: $${context.env.id}
      cost_center_id: $${resources['config.default#app-config'].outputs.cost_center_id}
  {{- end }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "custom-workload-with-label_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.custom-workload-with-label.id

}
