resource "humanitec_resource_definition" "aks-static-credentials" {
  driver_type = "humanitec/k8s-cluster-aks"
  id             = "aks-static-credentials"
  name           = "aks-static-credentials"
  type           = "k8s-cluster"
  driver_inputs  = {
    values_string  = jsonencode({
      "loadbalancer" = "20.10.10.10"
      "name" = "demo-123"
      "resource_group" = "my-resources"
      "subscription_id" = "12345678-aaaa-bbbb-cccc-0987654321ba"
      "server_app_id" = "6dae42f8-4368-4678-94ff-3960e28e3630"
    })
    secrets_string = jsonencode({
      "credentials" = {
        "appId" = "b520e4a8-6cb4-49dc-8f42-f3281dc2efe9"
        "displayName" = "my-cluster-sp"
        "password" = "my-cluster-sp-pw"
        "tenant" = "9b8c7b62-aaaa-4444-ffff-0987654321fd"
      }
    })
  }
}

