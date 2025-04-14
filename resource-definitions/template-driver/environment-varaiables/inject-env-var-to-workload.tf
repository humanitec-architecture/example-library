resource "humanitec_resource_definition" "inject-env-var-to-workload" {
  driver_type = "humanitec/template"
  id          = "inject-env-var-to-workload"
  name        = "inject-env-var-to-workload"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update:
  {{- range $containerId, $value := .resource.spec.containers }}
  - op: add
    path: /spec/containers/{{ $containerId }}/env
    value:
      - name: MY_ENV_VAR_A
        value: "my env value A"
      - name: MY_ENV_VAR_B
        value: "my env value B"
      - name: MY_ENV_VAR_C
        value: "my env value C"
  {{- end }}
END_OF_TEXT
      }
    })
  }
}
