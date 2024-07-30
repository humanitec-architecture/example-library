resource "humanitec_resource_definition" "serviceaccount-workload" {
  driver_type = "humanitec/template"
  id             = "serviceaccount-workload"
  name           = "serviceaccount-workload"
  type           = "workload"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "outputs" = "update: \n- op: add\n  path: /spec/serviceAccountName\n  value: $${resources.k8s-service-account.outputs.name}"
      }
    })
  }
}

