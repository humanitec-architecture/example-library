resource "humanitec_resource_definition" "gke-dynamic-credentials" {
  driver_type    = "humanitec/k8s-cluster-gke"
  id             = "gke-dynamic-credentials"
  name           = "gke-dynamic-credentials"
  type           = "k8s-cluster"
  driver_account = "gcp-dynamic-creds"
  driver_inputs = {
    values_string = jsonencode({
      "loadbalancer" = "35.10.10.10"
      "name"         = "demo-123"
      "zone"         = "europe-west2-a"
      "project_id"   = "my-gcp-project"
    })
  }
}

