resource "humanitec_resource_definition" "namespace" {
  id          = "custom-namespace"
  name        = "custom-namespace"
  type        = "k8s-namespace"
  driver_type = "humanitec/template"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        init      = "name: $${context.env.id}-$${context.app.id}"
        manifests = <<EOL
namespace.yaml:
  location: cluster
  data:
    apiVersion: v1
    kind: Namespace
    metadata:
      labels:
        pod-security.kubernetes.io/enforce: restricted
      name: {{ .init.name }}
EOL
        outputs   = "namespace: {{ .init.name }}"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "namespace" {
  resource_definition_id  = humanitec_resource_definition.namespace.id
  # ... add any matching criteria as required.
}