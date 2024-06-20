# This Resource Defintion provisions a Kubernetes ServiceAccount
resource "humanitec_resource_definition" "k8s_service_account" {
  driver_type = "humanitec/template"
  id          = "${var.prefix}k8s-service-account"
  name        = "${var.prefix}k8s-service-account"
  type        = "k8s-service-account"

  driver_inputs = {
    values_string = jsonencode({
      templates = {
        # Name the ServiceAccount after the Resource
        init      = <<EOL
name: {{ index (splitList "." "$${context.res.id}") 1 }}
EOL
        manifests = <<EOL
service-account.yaml:
  location: namespace
  data:
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: {{ .init.name }}
EOL
        outputs   = <<EOL
name: {{ .init.name }}
EOL
      }
    })
  }
}