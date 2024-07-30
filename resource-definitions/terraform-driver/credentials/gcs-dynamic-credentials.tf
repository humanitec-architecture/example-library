resource "humanitec_resource_definition" "gcs-dynamic-credentials" {
  driver_type = "humanitec/terraform"
  id             = "gcs-dynamic-credentials"
  name           = "gcs-dynamic-credentials"
  type           = "gcs"
  driver_account = "gcp-dynamic-creds"
  driver_inputs  = {
    values_string  = jsonencode({
      "variables" = {
        "location" = "europe-west3"
        "project_id" = "my-gcp-project"
      }
      "credentials_config" = {
        "variables" = {
          "access_token" = "access_token"
        }
      }
      "script" = <<END_OF_TEXT
# This provider block is using the Terraform variables
# set through the credentials_config.
# Variable declarations omitted for brevity.
provider "google" {
  project     = var.project_id
  access_token = var.access_token
}

# ... Terraform code reduced for brevity

resource "google_storage_bucket" "bucket" {
  name          = my-bucket
  location      = var.location
}
END_OF_TEXT
    })
  }
}

