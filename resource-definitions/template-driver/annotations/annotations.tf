resource "humanitec_resource_definition" "annotations" {
  driver_type = "humanitec/template"
  id          = "annotations"
  name        = "annotations"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update:
  - op: add
    path: /spec/deployment/annotations
    value:
      {{- range $key, $val := .resource.spec.deployment.annotations }}
      {{ $key }}: {{ $val | quote }}
      {{- end }}
  - op: add
    path: /spec/pod/annotations
    value:
      {{- range $key, $val := .resource.spec.pod.annotations }}
      {{ $key }}: {{ $val | quote }}
      {{- end }}
  # If the Score file also defines a service, add annotations to the service object
  {{- if .resource.spec.service }}
  - op: add
    path: /spec/service/annotations
    value:
      {{- range $key, $val := .resource.spec.service.annotations }}
      {{ $key }}: {{ $val | quote }}
      {{- end }}
  {{- $port := values .resource.spec.service.ports | first }}
  - op: add
    path: /spec/service/annotations/cloud.google.com~1neg
    value: '{"ingress":true,"exposed_ports":{ {{- $port.service_port | quote -}} :{}}}'
  {{- end }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "annotations_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.annotations.id

}
