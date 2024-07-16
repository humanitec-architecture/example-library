# Connect to a GKE cluster using temporary credentials defined via a Cloud Account
resource "humanitec_resource_definition" "gke-temporary" {
  id          = "gke-temporary"
  name        = "gke-temporary"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-gke"
  # The driver_account references a Cloud Account of type "gcp-identity"
  driver_account = humanitec_resource_account.gcp-temporary.id

  driver_inputs = {
    values_string = jsonencode({
      "name"         = var.gke_cluster_name
      "loadbalancer" = var.gke_loadbalancer
      "project_id"   = var.gcp_project_id
      "zone"         = var.gcp_region
    })
  }
}
