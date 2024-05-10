# EKS private cluster. It is to be accessed via the Humanitec Agent
# It is using a Cloud Account with dynamic credentials
resource "humanitec_resource_definition" "gke-agent" {
  id          = "gke-agent"
  name        = "gke-agent"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-gke"
  # The driver_account is referring to a Cloud Account resource
  driver_account = humanitec_resource_account.gcp-dynamic.id

  driver_inputs = {
    values_string = jsonencode({
      "name"         = var.gke_cluster_name
      "loadbalancer" = var.gke_loadbalancer
      "project_id"   = var.gcp_project_id
      "zone"         = var.gcp_region
    })
    # Setting the URL for the Humanitec Agent
    secrets_string = jsonencode({
      "agent_url" = "$${resources['agent#agent'].outputs.url}"
    })
  }
}
