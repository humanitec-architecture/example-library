resource "humanitec_resource_definition" "custom-workload" {
  driver_type = "humanitec/template"
  id             = "custom-workload"
  name           = "custom-workload"
  type           = "workload"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update:
  - op: add
    path: /spec/securityContext
    value:
      fsGroup: 1000
      runAsGroup: 1000
      runAsNonRoot: true
      runAsUser: 1000
      seccompProfile:
        type: RuntimeDefault
  {{- range $containerId, $value := .resource.spec.containers }}
  - op: add
    path: /spec/containers/{{ $containerId }}/securityContext
    value:
      allowPrivilegeEscalation: false
      capabilities:
        drop:
          - ALL
      privileged: false
      readOnlyRootFilesystem: true
  {{- end }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "custom-workload_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.custom-workload.id 

}
