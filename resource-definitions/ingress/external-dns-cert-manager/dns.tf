resource "humanitec_resource_definition" "external-dns-cert-manager-dns" {
  driver_type = "humanitec/dns-wildcard"
  id          = "external-dns-cert-manager-dns"
  name        = "external-dns-cert-manager-dns"
  type        = "dns"
  driver_inputs = {
    values_string = jsonencode({
      "domain"   = "staging.hosted-domain.com"
      "template" = "$${context.env.id}-$${context.app.id}"
    })
  }

  provision = {
    "ingress" = {
    }
  }
}

resource "humanitec_resource_definition_criteria" "external-dns-cert-manager-dns_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.external-dns-cert-manager-dns.id
  app_id                 = "external-dns-cert-manager-example-app"
}
