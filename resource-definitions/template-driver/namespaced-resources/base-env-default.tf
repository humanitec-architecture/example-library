resource "humanitec_resource_definition" "base-env-default" {
  driver_type = "humanitec/echo"
  id          = "base-env-default"
  name        = "base-env-default"
  type        = "base-env"
  driver_inputs = {
    values_string = jsonencode({
      "namespaced-resources" = {
        "resource-quota"   = "$${resources[\"base-env.default#resource-quota\"].guresid}"
        "network-policies" = "$${resources[\"base-env.default#network-policies\"].guresid}"
      }
    })
  }
}

