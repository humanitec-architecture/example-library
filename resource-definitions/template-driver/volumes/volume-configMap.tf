resource "humanitec_resource_definition" "volume-configmap" {
  driver_type = "humanitec/template"
  id          = "volume-configmap"
  name        = "volume-configmap"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "manifests" = {
          "configmap.yaml" = {
            "location" = "volumes"
            "data"     = <<END_OF_TEXT
name: $${context.res.guresid}-configmap
configMap:
  # The ConfigMap named here needs to exist. The Resource Definition does not create it
  name: log-config
  items:
    - key: log_level
      path: log_level.conf
END_OF_TEXT
          }
        }
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "volume-configmap_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.volume-configmap.id
  class                  = "config"
}
