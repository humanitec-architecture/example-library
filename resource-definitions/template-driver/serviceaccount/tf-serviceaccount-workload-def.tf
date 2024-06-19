# This Resource Definition adds a Kubernetes ServiceAccount to a Workload
resource "humanitec_resource_definition" "workload" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}workload"
  name        = "${var.prefix}workload"
  type        = "workload"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        init      = ""
        manifests = ""
        outputs   = <<EOL
update:
  - op: add
    path: /spec/serviceAccountName
    value: $${resources.k8s-service-account.outputs.name}
EOL
      }
    })
  }
}