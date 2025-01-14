resource "humanitec_resource_definition" "short-namespace" {
  driver_type = "humanitec/template"
  id          = "short-namespace"
  name        = "short-namespace"
  type        = "k8s-namespace"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = "name: {{ trunc 8 \"$${context.env.id}\" }}-{{ trunc 8 \"$${context.app.id}\" }}\n"
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

resource "humanitec_resource_definition_criteria" "short-namespace_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.short-namespace.id

}
