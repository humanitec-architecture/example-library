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
        "certificate-authority-data" = "LS0t...ca-data....=="
      }
    })
    secrets_string = jsonencode({
      "credentials" = {
        "client-certificate-data" = "LS0t...cert-data...=="
        "client-key-data"         = "LS0t...key-data...=="
      }
    })
  }
}

