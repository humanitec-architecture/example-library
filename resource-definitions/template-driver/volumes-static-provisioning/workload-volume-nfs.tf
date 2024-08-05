resource "humanitec_resource_definition" "workload-volume-nfs" {
  driver_type = "humanitec/template"
  id          = "workload-volume-nfs"
  name        = "workload-volume-nfs"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"    = <<END_OF_TEXT
pvcName: $${resources.volume.outputs.pvcName}
volumeName: $${resources.volume.outputs.volumeName}
END_OF_TEXT
        "outputs" = <<END_OF_TEXT
update:
  - op: add
    path: /spec/annotations/backup.org-name.io
    value: {{ .init.pvcName }}
  {{- range $containerId, $value := .resource.spec.containers }}
  - op: add
    path: /spec/containers/{{ $containerId }}/volumeMounts
    value:
    - name: {{ $.init.volumeName }}
      mountPath: /tmp/data
  {{- end }}
END_OF_TEXT
      }
    })
  }
}

