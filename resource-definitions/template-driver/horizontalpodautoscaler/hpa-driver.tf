resource "humanitec_resource_definition" "hpa-driver" {
  driver_type = "humanitec/hpa"
  id          = "hpa-driver"
  name        = "hpa-driver"
  type        = "horizontal-pod-autoscaler"
  driver_inputs = {
    values_string = jsonencode({
      "minReplicas"                    = 2
      "maxReplicas"                    = 5
      "targetCPUUtilizationPercentage" = 80
    })
  }
}

resource "humanitec_resource_definition_criteria" "hpa-driver_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.hpa-driver.id

}
