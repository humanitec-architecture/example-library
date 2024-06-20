# Provide access to the kubeconfig file
locals {
  parsed_kubeconfig = yamldecode(file("/path/to/kubeconfig"))
}

# Resource Definition for a generic Kubernetes cluster
resource "humanitec_resource_definition" "generic_cluster" {
  id          = "generic-k8s-static-credentials"
  name        = "generic-k8s-static-credentials"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster"

  driver_inputs = {
    values_string = jsonencode({
      loadbalancer = "35.10.10.10"
      # The index [0] assumes the target cluster is the first cluster definition
      cluster_data = local.parsed_kubeconfig["clusters"][0]["cluster"]
    })
    secrets_string = jsonencode({
      # Setting the URL for the Humanitec Agent. Remove the line if not used
      agent_url   = "$${resources['agent#agent'].outputs.url}"
      # The index [0] assumes the target user is the first user definition
      credentials = local.parsed_kubeconfig["users"][0]["user"]
    })
  }
}