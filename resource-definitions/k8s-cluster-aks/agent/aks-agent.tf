# AKS private cluster. It is to be accessed via the Humanitec Agent
# It is using a Cloud Account to obtain credentials
resource "humanitec_resource_definition" "aks-private-dev-dynamic-credentials" {
  id          = "aks-agent"
  name        = "aks-agent"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-aks"
  # The driver_account is referring to a Cloud Account resource
  driver_account = humanitec_resource_account.azure-dynamic.id

  driver_inputs = {
    values_string = jsonencode({
      "name"            = var.azure_aks_private_cluster_name
      "resource_group"  = var.azure_aks_resource_group
      "subscription_id" = var.azure_subscription_id
      # Add this exact server_app_id for a cluster using AKS-managed Entra ID integration
      # "server_app_id" = "6dae42f8-4368-4678-94ff-3960e28e3630"
    })
    # Setting the URL for the Humanitec Agent
    secrets_string = jsonencode({
      "agent_url" = "$${resources['agent#agent'].outputs.url}"
    })
  }
}
