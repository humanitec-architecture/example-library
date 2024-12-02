resource "humanitec_resource_definition" "volume-ebs" {
  driver_type = "humanitec/volume-pvc"
  id          = "volume-ebs"
  name        = "volume-ebs"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "access_modes"       = "ReadWriteOnce"
      "capacity"           = "5Gi"
      "storage_class_name" = "ebs-sc"
    })
  }
}

resource "humanitec_resource_definition_criteria" "volume-ebs_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.volume-ebs.id
  class                  = "ebs"
}
