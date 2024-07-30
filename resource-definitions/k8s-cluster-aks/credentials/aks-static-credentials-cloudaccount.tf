resource "humanitec_resource_definition" "aks-static-credentials-cloudaccount" {
  driver_type    = "humanitec/k8s-cluster-aks"
  id             = "aks-static-credentials-cloudaccount"
  name           = "aks-static-credentials-cloudaccount"
  type           = "k8s-cluster"
  driver_account = "azure-static-creds"
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

