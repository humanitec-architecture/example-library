resource "humanitec_resource_definition" "gke-temporary-credentials" {
  driver_type    = "humanitec/k8s-cluster-gke"
  id             = "gke-temporary-credentials"
  name           = "gke-temporary-credentials"
  type           = "k8s-cluster"
  driver_account = "gcp-temporary-creds"
  driver_inputs = {
    values_string = jsonencode({
      "loadbalancer" = "35.10.10.10"
      "name"         = "demo-123"
      "zone"         = "europe-west2-a"
      "project_id"   = "my-gcp-project"
    })
  }
}

resource "humanitec_resource_definition_criteria" "gke-temporary-credentials_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.gke-temporary-credentials.id
  res_id                 = "k8s-cluster-runtime"
}
