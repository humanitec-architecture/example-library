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
  {{- if .resource.spec.service }}
  {{- $port := values .resource.spec.service.ports | first }}
  - op: add
    path: /spec/service/annotations/cloud.google.com~1neg
    value: '{"ingress":true,"exposed_ports":{ {{- $port.service_port | quote -}} :{}}}'
  {{- end}}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "annotations_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.annotations.id

}
