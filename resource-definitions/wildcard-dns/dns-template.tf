resource "humanitec_resource_definition" "dns-template" {
  driver_type = "humanitec/dns-wildcard"
  id          = "dns-template"
  name        = "dns-template"
  type        = "dns"
  driver_inputs = {
    values_string = jsonencode({
      "domain"   = "my-test-domain.com"
      "template" = "{{ index (splitList "." "$${context.res.id}") 1 }}-$${context.env.id}-$${context.app.id}"
    })
  }
}

