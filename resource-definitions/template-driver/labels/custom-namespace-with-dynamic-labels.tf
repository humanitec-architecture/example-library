resource "humanitec_resource_definition" "custom-namespace-with-label" {
  driver_type = "humanitec/template"
  id          = "custom-namespace-with-label"
  name        = "custom-namespace-with-label"
  type        = "k8s-namespace"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = "name: $${context.app.id}-$${context.env.id}\n"
        "manifests" = <<END_OF_TEXT
namespace.yaml:
  location: cluster
  data:
    apiVersion: v1
    kind: Namespace
    metadata:
      labels:
        env_id: $${context.env.id}
        cost_center_id: $${resources['config.default#app-config'].outputs.cost_center_id}
      name: {{ .init.name }}
END_OF_TEXT
        "outputs"   = "namespace: {{ .init.name }}\n"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "custom-namespace-with-label_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.custom-namespace-with-label.id

}
