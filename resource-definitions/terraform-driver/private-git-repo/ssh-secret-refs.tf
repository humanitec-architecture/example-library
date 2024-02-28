resource "humanitec_resource_definition" "example-resource" {
  driver_type = "humanitec/terraform"
  id          = "example-resource"
  name        = "example-resource"
  type        = "some-resource-type"

  driver_inputs = {
    # This examples uses secret references, pointing at a secret store
    # to obtain the actual values
    secret_refs = jsonencode({

      source = {
        # Using the ssh_key for a connection to the Git repo via SSH
        ssh_key = {
          ref   = var.ssh_key_secret_reference_key
          store = var.secret_store
        }
      }

      variables = {
        # ...
      }
    })

    values_string = jsonencode({
      # Connection information to the target Git repo
      source = {
        path = var.tf_module_github_path
        rev  = var.tf_module_github_ref
        url  = var.tf_module_github_url # Format: "git@mydomain.com:my-org/my-repo.git"
      }
      # ...
    })
  }
}