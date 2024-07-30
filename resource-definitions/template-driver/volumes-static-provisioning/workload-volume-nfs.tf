resource "humanitec_resource_definition" "workload-volume-nfs" {
  driver_type = "humanitec/template"
  id             = "workload-volume-nfs"
  name           = "workload-volume-nfs"
  type           = "workload"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "init" = <<END_OF_TEXT
pvcName: $${resources.volume.outputs.pvcName}
volumeName: $${resources.volume.outputs.volumeName}
END_OF_TEXT
        "outputs" = "update:\n  - op: add\n    path: /spec/annotations/backup.org-name.io\n    value: {{ .init.pvcName }}\n  {{- range $containerId, $value := .resource.spec.containers }}\n  - op: add\n    path: /spec/containers/{{ $containerId }}/volumeMounts\n    value:\n    - name: {{ $.init.volumeName }}\n      mountPath: /tmp/data\n  {{- end }}"
      }
    })
  }
}

