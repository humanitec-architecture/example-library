resource "humanitec_resource_definition" "serviceaccount-workload" {
  driver_type = "humanitec/template"
  id          = "serviceaccount-workload"
  name        = "serviceaccount-workload"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update: 
- op: add
  path: /spec/serviceAccountName
  value: $${resources.k8s-service-account.outputs.name}
END_OF_TEXT
      }
    })
  }
}

