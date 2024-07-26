resource "humanitec_resource_definition" "custom-namespace-with-label" {
  driver_type = "humanitec/template"
  id          = "custom-namespace-with-label"
  name        = "custom-namespace-with-label"
  type        = "k8s-namespace"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = "name: $${context.app.id}-$${context.env.id}\n"
        "manifests" = "namespace.yaml:\n  location: cluster\n  data:\n    apiVersion: v1\n    kind: Namespace\n    metadata:\n      labels:\n        env_id: $${context.env.id}\n        cost_center_id: $${resources['config.default#app-config'].outputs.cost_center_id}\n      name: {{ .init.name }}"
        "outputs"   = "namespace: {{ .init.name }}\n"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "custom-namespace-with-label_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.custom-namespace-with-label.id

}
