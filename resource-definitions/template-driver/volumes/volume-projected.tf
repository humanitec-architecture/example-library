resource "humanitec_resource_definition" "volume-projected" {
  driver_type = "humanitec/template"
  id          = "volume-projected"
  name        = "volume-projected"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "manifests" = {
          "projected.yaml" = {
            "location" = "volumes"
            "data"     = <<END_OF_TEXT
name: $${context.res.guresid}-projected
projected:
  sources:
  - downwardAPI:
      items:
        - path: "labels"
          fieldRef:
            fieldPath: metadata.labels
  - configMap:
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

resource "humanitec_resource_definition_criteria" "volume-projected_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.volume-projected.id
  class                  = "projected"
}
