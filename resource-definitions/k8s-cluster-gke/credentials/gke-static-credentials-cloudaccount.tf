resource "humanitec_resource_definition" "gke-static-credentials-cloudaccount" {
  driver_type = "humanitec/k8s-cluster-gke"
  id             = "gke-static-credentials-cloudaccount"
  name           = "gke-static-credentials-cloudaccount"
  type           = "k8s-cluster"
  driver_account = "gcp-static-creds"
  driver_inputs  = {
    values_string  = jsonencode({
      "loadbalancer" = "35.10.10.10"
      "name" = "demo-123"
      "zone" = "europe-west2-a"
      "project_id" = "my-gcp-project"
    })
  }
}

