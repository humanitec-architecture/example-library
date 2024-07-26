resource "humanitec_resource_definition" "gcp-file-credentials" {
  driver_type    = "humanitec/terraform"
  id             = "gcp-file-credentials"
  name           = "gcp-file-credentials"
  type           = "gcs"
  driver_account = "$${resources['config.default#gcp-account'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "credentials_config" = {
        "file" = "credentials.json"
      }
      "script" = "\nvariable \"project_id\" {}\nvariable \"location\" {}\n\nterraform {\n  required_providers {\n    google = {\n      source = \"hashicorp/google\"\n    }\n  }\n}\nprovider \"google\" {\n  project     = var.project_id\n\n  # The file is defined above. The provider will read a service account token from this file.\n  credentials = \"credentials.json\"\n}\n\noutput \"name\" {\n  value = google_storage_bucket.bucket.name\n}\n\nresource \"google_storage_bucket\" \"bucket\" {\n  name          = \"$\\{replace(\"$${context.res.id}\", \"/^.*\\\\./\", \"\")}-standard-$${context.env.id}-$${context.app.id}-$${context.org.id}\"\n  location      = var.location\n  force_destroy = true\n}"
      "variables" = {
        "location"   = "$${resources.config#gcp-account.outputs.location}"
        "project_id" = "$${resources.config#gcp-account.outputs.project_id}"
      }
    })
  }
}


