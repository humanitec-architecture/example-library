resource "humanitec_resource_definition" "volume-pvc" {
  driver_type = "humanitec/volume-pvc"
  id          = "volume-pvc"
  name        = "volume-pvc"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "access_modes" = "ReadWriteOnce"
      "capacity"     = "10Gi"
    })
  }
}

resource "humanitec_resource_definition_criteria" "volume-pvc_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.volume-pvc.id

}
