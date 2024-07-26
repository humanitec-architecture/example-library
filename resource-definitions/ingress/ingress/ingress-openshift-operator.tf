resource "humanitec_resource_definition" "openshift-ingress" {
  driver_type = "humanitec/ingress"
  id          = "openshift-ingress"
  name        = "openshift-ingress"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "class" = "openshift-default"
    })
  }
}

