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
        # Using the password for a connection to the Git repo via HTTPS
        password = {
          ref   = var.password_secret_reference_key
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
        path   = "some-resource-type/terraform"
        branch = "refs/heads/main"
        url    = "https://my-domain.com/my-org/my-repo.git"
      }
      # ...
    })
  }
}
