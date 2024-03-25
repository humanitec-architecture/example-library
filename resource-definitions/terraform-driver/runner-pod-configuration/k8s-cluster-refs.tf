resource "humanitec_resource_definition" "aks_aad_resource_cluster" {
  id          = "aad-enabled-cluster"
  name        = "aad-enabled-cluster"
  type        = "k8s-cluster"
  driver_type = "humanitec/k8s-cluster-aks"

  driver_inputs = {
    secrets = {
      credentials = {
        appId       = var.app_id
        displayName = var.display_name
        password    = var.password
        tenant      = var.tenant
      }
    }

    values = {
      name            = "my-cluster"
      resource_group  = "my-azure-resource-group"
      subscription_id = "123456-1234-1234-1234-123456789"
      server_app_id   = "6dae42f8-4368-4678-94ff-3960e28e3630"
    }
  }
}


resource "humanitec_resource_definition_criteria" "aks_aad_resource_cluster" {
  resource_definition_id = humanitec_resource_definition.aks_aad_resource_cluster.id
  class                  = "runner"
}
