resource "humanitec_resource_definition" "volume-standard-dynamic" {
  driver_type = "humanitec/template"
  id          = "volume-standard-dynamic"
  name        = "volume-standard-dynamic"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init" = <<END_OF_TEXT
# Generate a unique id for each pv/pvc combination.
# Every Workload will have a separate pv and pvc created for it,
# but pointing to the same NFS server endpoint.
volumeUid: {{ randNumeric 4 }}-{{ randNumeric 4 }}
pvBaseName: pv-tmpl-
pvcBaseName: pvc-tmpl-
volBaseName: vol-tmpl-
END_OF_TEXT
        "manifests" = {
          "app-pvc-tmpl.yaml" = {
            "location" = "namespace"
            "data"     = <<END_OF_TEXT
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .init.pvcBaseName }}{{ .init.volumeUid }}
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: "standard-rwo"
  resources:
    requests:
      storage: 10Gi
  volumeName: {{ .init.pvBaseName }}{{ .init.volumeUid }}
END_OF_TEXT
          }
          "app-vol-tmpl.yaml" = {
            "location" = "volumes"
            "data"     = <<END_OF_TEXT
name: {{ .init.volBaseName }}{{ .init.volumeUid }}
persistentVolumeClaim:
  claimName: {{ .init.pvcBaseName }}{{ .init.volumeUid }}
END_OF_TEXT
          }
        }
        "outputs" = <<END_OF_TEXT
volumeName: {{ .init.volBaseName }}{{ .init.volumeUid }}
pvcName: {{ .init.pvcBaseName }}{{ .init.volumeUid }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "volume-standard-dynamic_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.volume-standard-dynamic.id
  class                  = "standard-rwo"
}
