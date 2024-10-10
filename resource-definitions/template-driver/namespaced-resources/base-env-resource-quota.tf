resource "humanitec_resource_definition" "base-env-resource-quota" {
  driver_type = "humanitec/template"
  id          = "base-env-resource-quota"
  name        = "base-env-resource-quota"
  type        = "base-env"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "manifests" = "quota.yaml:\n  location: namespace\n  data:\n    apiVersion: v1\n    kind: ResourceQuota\n    metadata:\n      name: compute-resources\n    spec:\n      hard:\n        limits.cpu: 1\n        limits.memory: 256Mi"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "base-env-resource-quota_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.base-env-resource-quota.id
  res_id                 = "resource-quota"
}
