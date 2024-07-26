resource "humanitec_resource_definition" "serviceaccount-k8s-service-account" {
  driver_type = "humanitec/template"
  id          = "serviceaccount-k8s-service-account"
  name        = "serviceaccount-k8s-service-account"
  type        = "k8s-service-account"
  driver_inputs = {
    values_string = jsonencode({
      "res_id" = "$${context.res.id}"
      "templates" = {
        "init"      = "name: {{ index (splitList \".\" \"$${context.res.id}\") 1 }}\n"
        "outputs"   = "name: {{ .init.name }}\n"
        "manifests" = "service-account.yaml:\n  location: namespace\n  data:\n    apiVersion: v1\n    kind: ServiceAccount\n    metadata:\n      name: {{ .init.name }}"
      }
    })
  }
}

