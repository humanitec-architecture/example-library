resource "humanitec_resource_definition" "workload-affinity" {
  driver_type = "humanitec/template"
  id          = "workload-affinity"
  name        = "workload-affinity"
  type        = "workload"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update:
- op: add
  path: /spec/affinity
  value: 
    nodeAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: another-node-label-key
            operator: In
            values:
            - another-node-label-value
END_OF_TEXT
      }
    })
  }
}


