resource "humanitec_resource_definition" "namespace-echo" {
  driver_type = "humanitec/echo"
  id          = "namespace-echo"
  name        = "namespace-echo"
  type        = "k8s-namespace"
  driver_inputs = {
    values_string = jsonencode({
      "namespace" = "$${context.app.id}-$${context.env.id}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "namespace-echo_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.namespace-echo.id

}
