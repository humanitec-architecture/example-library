resource "humanitec_resource_definition" "gke-static-credentials" {
  driver_type = "humanitec/k8s-cluster-gke"
  id          = "gke-static-credentials"
  name        = "gke-static-credentials"
  type        = "k8s-cluster"
  driver_inputs = {
    values_string = jsonencode({
      "loadbalancer" = "35.10.10.10"
      "name"         = "demo-123"
      "zone"         = "europe-west2-a"
      "project_id"   = "my-gcp-project"
    })
    secrets_string = jsonencode({
      "credentials" = {
        "type"                        = "service_account"
        "project_id"                  = "my-gcp-project"
        "private_key_id"              = "$${PRIVATE_KEY_ID}"
        "private_key"                 = "$${PRIVATE_KEY}"
        "client_id"                   = "$${CLIENT_ID}"
        "client_email"                = "my-service-account@my-gcp-project.iam.gserviceaccount.com"
        "auth_uri"                    = "https://accounts.google.com/o/oauth2/auth"
        "token_uri"                   = "https://oauth2.googleapis.com/token"
        "auth_provider_x509_cert_url" = "https://www.googleapis.com/oauth2/v1/certs"
        "client_x509_cert_url"        = "https://www.googleapis.com/robot/v1/metadata/x509/my-service-account%40my-gcp-project.iam.gserviceaccount.com"
      }
    })
  }
}

