resource "humanitec_resource_definition" "inject-env-var-to-workload" {
  driver_type = "humanitec/template"
  id          = "inject-env-var-to-workload"
  name        = "inject-env-var-to-workload"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = "update:\n  {{- range $containerId, $value := .resource.spec.containers }}\n  - op: add\n    path: /spec/containers/{{ $containerId }}/env\n    value:\n      - name: MY_ENV_VAR_A\n        value: \"my env value A\"\n      - name: MY_ENV_VAR_B\n        value: \"my env value B\"\n      - name: MY_ENV_VAR_C\n        value: \"my env value C\"\n  {{- end }}"
      }
    })
  }
}

