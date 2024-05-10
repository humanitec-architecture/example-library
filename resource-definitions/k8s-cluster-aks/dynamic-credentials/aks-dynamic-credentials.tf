# AKS private cluster. It is using a Cloud Account with dynamic credentials
resource "humanitec_resource_definition" "aks-dynamic-credentials" {
  id          = "aks-dynamic-credentials"
  name        = "aks-dynamic-credentials"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-aks"
  # The driver_account is referring to a Cloud Account resource
  driver_account = humanitec_resource_account.azure-dynamic.id

  driver_inputs = {
    values_string = jsonencode({
      "name"            = var.azure_aks_private_cluster_name
      "loadbalancer"    = var.azure_aks_private_cluster_loadbalancer
      "resource_group"  = var.azure_aks_resource_group
      "subscription_id" = var.azure_subscription_id
      # Add this exact server_app_id for a cluster using AKS-managed Entra ID integration
      # "server_app_id" = "6dae42f8-4368-4678-94ff-3960e28e3630"
    })
  }
}
