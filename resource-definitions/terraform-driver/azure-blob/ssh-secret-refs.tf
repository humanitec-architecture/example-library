resource "humanitec_resource_definition" "azure-blob" {
  driver_type = "humanitec/terraform"
  id          = "azure-blob"
  name        = "azure-blob"
  type        = "azure-blob"

  driver_inputs = {
    # All secrets are read from a secret store using secret references
    secret_refs = jsonencode({
      variables = {
        client_id = {
          ref   = var.client_id_secret_reference_key
          store = var.secret_store
        }
        client_secret = {
          ref   = var.client_secret_secret_reference_key
          store = var.secret_store
        }
      }

      source = {
        # Using an SSH key to authenticate against the Git repo providing the Terraform module
        ssh_key = {
          ref   = var.ssh_key_secret_reference_key
          store = var.secret_store
        }
      }
    })

    values_string = jsonencode({
      source = {
        path = "azure-blob/terraform/"
        rev  = "refs/heads/main"
        url  = "git@my-domain.com:my-org/my-repo.git"
      }

      variables = {
        # Variables for the Terraform module located in the Git repo
        tenant_id                = var.tenant_id
        subscription_id          = var.subscription_id
        resource_group_name      = var.resource_group_name
        name                     = var.name
        prefix                   = var.prefix
        account_tier             = var.account_tier
        account_replication_type = var.account_replication_type
        container_name           = var.container_name
        container_access_type    = var.container_access_type
      }
    })
  }
}
