resource "humanitec_resource_definition" "workload-toleration" {
  driver_type = "humanitec/template"
  id          = "workload-toleration"
  name        = "workload-toleration"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update: 
- op: add
  path: /spec/tolerations
  value:
  - key: "example-key"
    operator: "Exists"
    effect: "NoSchedule"
END_OF_TEXT
      }
    })
  }
}


