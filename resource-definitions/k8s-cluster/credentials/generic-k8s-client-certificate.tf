resource "humanitec_resource_definition" "generic-k8s-static-credentials" {
  driver_type = "humanitec/k8s-cluster"
  id          = "generic-k8s-static-credentials"
  name        = "generic-k8s-static-credentials"
  type        = "k8s-cluster"
  driver_inputs = {
    values_string = jsonencode({
      "name"         = "my-generic-k8s-cluster"
      "loadbalancer" = "35.10.10.10"
      "cluster_data" = {
        "server"                     = "https://35.11.11.11:6443"
        "certificate-authority-data" = "$${CLUSTER_CERTIFICATE_CA_DATA}"
      }
    })
    secrets_string = jsonencode({
      "credentials" = {
        "client-certificate-data" = "$${USER_CLIENT_CERTIFICATE_DATA}"
        "client-key-data"         = "$${USER_CLIENT_KEY_DATA}"
      }
    })
  }
}

