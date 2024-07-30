resource "humanitec_resource_definition" "kong-ingress" {
  driver_type = "humanitec/ingress"
  id             = "kong-ingress"
  name           = "kong-ingress"
  type           = "ingress"
  driver_inputs  = {
    values_string  = jsonencode({
      "annotations" = {
        "konghq.com/preserve-host" = "false"
        "konghq.com/strip-path" = "true"
      }
      "api_version" = "v1"
      "class" = "kong"
    })
  }
}

