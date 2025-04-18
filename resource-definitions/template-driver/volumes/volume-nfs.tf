resource "humanitec_resource_definition" "volume-nfs" {
  driver_type = "humanitec/template"
  id          = "volume-nfs"
  name        = "volume-nfs"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "cookie" = <<END_OF_TEXT
# Store the volumeUid in a cookie to be reused for subsequent deployments
volumeUid: {{ .init.volumeUid }}
END_OF_TEXT
        "init"   = <<END_OF_TEXT
# Generate a unique id for each pv/pvc combination.
# Every Workload will have a separate pv and pvc created for it,
# but pointing to the same NFS server endpoint.
{{- if and .cookie .cookie.volumeUid }}
volumeUid: {{ .cookie.volumeUid }}
{{- else }}
volumeUid: {{ randNumeric 4 }}-{{ randNumeric 4 }}
{{- end }}
pvBaseName: pv-tmpl-
pvcBaseName: pvc-tmpl-
volBaseName: vol-tmpl-
END_OF_TEXT
        "manifests" = {
          "app-pv-tmpl.yaml" = {
            "location" = "namespace"
            "data"     = <<END_OF_TEXT
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ .init.pvBaseName }}{{ .init.volumeUid }}
spec:
  capacity:
    storage: 1Mi
  accessModes:
    - ReadWriteMany
  nfs:
    server: nfs-server.default.svc.cluster.local
    path: "/"
  mountOptions:
    - nfsvers=4.2
END_OF_TEXT
          }
          "app-pvc-tmpl.yaml" = {
            "location" = "namespace"
            "data"     = <<END_OF_TEXT
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .init.pvcBaseName }}{{ .init.volumeUid }}
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: ""
  resources:
    requests:
      storage: 1Mi
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

resource "humanitec_resource_definition_criteria" "volume-nfs_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.volume-nfs.id
  class                  = "nfs"
}
