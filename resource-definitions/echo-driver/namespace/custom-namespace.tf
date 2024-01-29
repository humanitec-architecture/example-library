resource "humanitec_resource_definition" "k8s_namespace" {
  driver_type = "humanitec/echo"
  id          = "default-namespace"
  name        = "default-namespace"
  type        = "k8s-namespace"

  driver_inputs = {
    values_string = jsonencode({
      "namespace" = "$${context.app.id}-$${context.env.id}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "k8s_namespace" {
  resource_definition_id = humanitec_resource_definition.k8s_namespace.id
}