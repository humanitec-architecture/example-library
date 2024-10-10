resource "humanitec_resource_definition" "base-env-network-policies" {
  driver_type = "humanitec/template"
  id          = "base-env-network-policies"
  name        = "base-env-network-policies"
  type        = "base-env"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "manifests" = "network-policies.yaml:\n  location: namespace\n  data:\n    apiVersion: networking.k8s.io/v1\n    kind: NetworkPolicy\n    metadata:\n      name: default-deny-egress\n    spec:\n      podSelector: {}\n      policyTypes:\n      - Egress"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "base-env-network-policies_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.base-env-network-policies.id
  res_id                 = "network-policies"
}
