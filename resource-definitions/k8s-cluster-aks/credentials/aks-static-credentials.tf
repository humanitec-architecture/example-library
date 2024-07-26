resource "humanitec_resource_definition" "aks-static-credentials" {
  driver_type = "humanitec/k8s-cluster-aks"
  id          = "aks-static-credentials"
  name        = "aks-static-credentials"
  type        = "k8s-cluster"
  driver_inputs = {
    values_string = jsonencode({
      "loadbalancer"    = "20.10.10.10"
      "name"            = "demo-123"
      "resource_group"  = "my-resources"
      "subscription_id" = "12345678-aaaa-bbbb-cccc-0987654321ba"
    })
    secrets_string = jsonencode({
      "credentials" = {
        "appId"       = "b520e4a8-6cb4-49dc-8f42-f3281dc2efe9"
        "displayName" = "my-cluster-sp"
        "password"    = "$${SERVICE_PRINCIPAL_PASSWORD}"
        "tenant"      = "9b8c7b62-aaaa-4444-ffff-0987654321fd"
      }
    })
  }
}

