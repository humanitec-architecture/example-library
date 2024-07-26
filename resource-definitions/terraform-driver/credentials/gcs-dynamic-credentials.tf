resource "humanitec_resource_definition" "gcs-dynamic-credentials" {
  driver_type    = "humanitec/terraform"
  id             = "gcs-dynamic-credentials"
  name           = "gcs-dynamic-credentials"
  type           = "gcs"
  driver_account = "gcp-dynamic-creds"
  driver_inputs = {
    values_string = jsonencode({
      "variables" = {
        "location"   = "europe-west3"
        "project_id" = "my-gcp-project"
      }
      "credentials_config" = {
        "variables" = {
          "access_token" = "access_token"
        }
      }
      "script" = "# This provider block is using the Terraform variables\n# set through the credentials_config.\n# Variable declarations omitted for brevity.\nprovider \"google\" {\n  project     = var.project_id\n  access_token = var.access_token\n}\n\n# ... Terraform code reduced for brevity\n\nresource \"google_storage_bucket\" \"bucket\" {\n  name          = my-bucket\n  location      = var.location\n}"
    })
  }
}

