resource "humanitec_resource_definition" "dns-template" {
  driver_type = "humanitec/dns-wildcard"
  id          = "dns-template"
  name        = "dns-template"
  type        = "dns"
  driver_inputs = {
    values_string = jsonencode({
      "domain"   = "my-domain.com"
      "template" = "{{ index (splitList \".\" \"$${context.res.id}\") 1 }}-$${context.env.id}-$${context.app.id}"
    })
  }

  provision = {
    "ingress" = {
      is_dependent = false
    }
  }
}

resource "humanitec_resource_definition_criteria" "dns-template_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.dns-template.id

}
