resource "humanitec_resource_definition" "aks-temporary-credentials" {
  driver_type    = "humanitec/k8s-cluster-aks"
  id             = "aks-temporary-credentials"
  name           = "aks-temporary-credentials"
  type           = "k8s-cluster"
  driver_account = "azure-temporary-creds"
  driver_inputs = {
    values_string = jsonencode({
      "loadbalancer"    = "20.10.10.10"
      "name"            = "demo-123"
      "resource_group"  = "my-resources"
      "subscription_id" = "12345678-aaaa-bbbb-cccc-0987654321ba"
      "server_app_id"   = "6dae42f8-4368-4678-94ff-3960e28e3630"
    })
  }
}

