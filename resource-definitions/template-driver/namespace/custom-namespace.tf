resource "humanitec_resource_definition" "custom-namespace" {
  driver_type = "humanitec/template"
  id          = "custom-namespace"
  name        = "custom-namespace2"
  type        = "k8s-namespace"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = "name: $${context.env.id}-$${context.app.id}\n"
        "manifests" = "namespace.yaml:\n  location: cluster\n  data:\n    apiVersion: v1\n    kind: Namespace\n    metadata:\n      labels:\n        pod-security.kubernetes.io/enforce: restricted\n      name: {{ .init.name }}"
        "outputs"   = "namespace: {{ .init.name }}\n"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "custom-namespace_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.custom-namespace.id

}
