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
  # Option 1: separate ServiceAccount per workload. Using the current workload's ID by not specifying an ID
  value: $${resources.k8s-service-account.outputs.name}
  # Option 2: single ServiceAccount for all workloads. Specifying a fixed ID, e.g. "ksa"
  # value: $${resources.k8s-service-account#ksa.outputs.name}
END_OF_TEXT
      }
    })
  }
}

