resource "humanitec_resource_definition" "dns-template" {
  driver_type = "humanitec/dns-wildcard"
  id          = "dns-template"
  name        = "dns-template"
  type        = "dns"
  driver_inputs = {
    values_string = jsonencode({
      "domain"   = "my-test-domain.com"
      "template" = "preview-$${context.app.id}-$${context.env.id}"
    })
  }
}

