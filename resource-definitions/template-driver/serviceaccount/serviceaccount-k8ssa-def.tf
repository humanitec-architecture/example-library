resource "humanitec_resource_definition" "serviceaccount-k8s-service-account" {
  driver_type = "humanitec/template"
  id          = "serviceaccount-k8s-service-account"
  name        = "serviceaccount-k8s-service-account"
  type        = "k8s-service-account"
  driver_inputs = {
    values_string = jsonencode({
      "res_id" = "$${context.res.id}"
      "templates" = {
        "init"      = <<END_OF_TEXT
res_id: {{ .driver.values.res_id }}
{{- $res_name := .driver.values.res_id | splitList "." | last }}
name: {{ $res_name | toRawJson }}
END_OF_TEXT
        "outputs"   = "name: {{ .init.name }}\n"
        "manifests" = <<END_OF_TEXT
service-account.yaml:
  location: namespace
  data:
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: {{ .init.name }}
      annotations:
        hum-res: {{ .init.res_id }}
END_OF_TEXT
      }
    })
  }
}

