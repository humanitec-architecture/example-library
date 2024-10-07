resource "humanitec_resource_definition" "example-k8s-service-account" {
  driver_type = "humanitec/template"
  id          = "example-k8s-service-account"
  name        = "example-k8s-service-account"
  type        = "k8s-service-account"
  driver_inputs = {
    values_string = jsonencode({
      "res_id" = "$${context.res.id}"
      "templates" = {
        "init"      = "name: {{ .driver.values.res_id | splitList \".\" | last }}-sa\n"
        "outputs"   = "name: {{ .init.name }}\n"
        "manifests" = <<END_OF_TEXT
service-account.yaml:
  location: namespace
  data: |
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: {{ .init.name }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "example-k8s-service-account_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.example-k8s-service-account.id
  app_id                 = "example-propagate-id"
}
