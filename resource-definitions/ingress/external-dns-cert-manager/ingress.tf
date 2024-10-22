resource "humanitec_resource_definition" "external-dns-cert-manager-ingress" {
  driver_type = "humanitec/ingress"
  id          = "external-dns-cert-manager-ingress"
  name        = "external-dns-cert-manager-ingress"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "annotations" = {
        "cert-manager.io/cluster-issuer"            = "my-cluster-certificate-issue"
        "external-dns.alpha.kubernetes.io/hostname" = "$${resources.dns.outputs.host}"
      }
      "class"           = "nginx"
      "tls_secret_name" = "tls-cert-$${resources.dns.guresid}"
    })
  }
}

resource "humanitec_resource_definition_criteria" "external-dns-cert-manager-ingress_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.external-dns-cert-manager-ingress.id
  app_id                 = "external-dns-cert-manager-example-app"
}
