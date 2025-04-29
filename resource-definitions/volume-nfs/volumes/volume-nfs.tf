resource "humanitec_resource_definition" "volume-nfs" {
  driver_type = "humanitec/volume-nfs"
  id          = "volume-nfs"
  name        = "volume-nfs"
  type        = "volume"
  driver_inputs = {
    values_string = jsonencode({
      "path"   = "/"
      "server" = "nfs-server.default.svc.cluster.local"
    })
  }
}

resource "humanitec_resource_definition_criteria" "volume-nfs_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.volume-nfs.id
  class                  = "nfs"
}
