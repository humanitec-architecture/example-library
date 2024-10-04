resource "humanitec_resource_definition" "example-workload" {
  driver_type = "humanitec/template"
  id          = "example-workload"
  name        = "example-workload"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update: 
- op: add
  path: /spec/serviceAccountName
  {{/*
    The resource reference does not specify ID or class so the ID and
    class of the workload being provisioned will be used.
  *//}
  value: $${resources.k8s-service-account.outputs.name}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "example-workload_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.example-workload.id
  app_id                 = "example-break-a-loop-additional-resource"
}
