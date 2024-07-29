resource "humanitec_resource_definition" "custom-namespace" {
  driver_type = "humanitec/template"
  id          = "custom-namespace"
  name        = "custom-namespace2"
  type        = "k8s-namespace"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = "name: $${context.env.id}-$${context.app.id}\n"
        "manifests" = <<END_OF_TEXT
namespace.yaml:
  location: cluster
  data:
    apiVersion: v1
    kind: Namespace
    metadata:
      labels:
        pod-security.kubernetes.io/enforce: restricted
      name: {{ .init.name }}
END_OF_TEXT
        "outputs"   = "namespace: {{ .init.name }}\n"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "custom-namespace_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.custom-namespace.id

}
