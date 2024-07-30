resource "humanitec_resource_definition" "account-config-gcp" {
  driver_type    = "humanitec/echo"
  id             = "account-config-gcp"
  name           = "account-config-gcp"
  type           = "config"
  driver_account = "gcp-credentials"
  driver_inputs = {
    values_string = jsonencode({
      "location"   = "US"
      "project_id" = "my-gcp-prject"
    })
  }
}

resource "humanitec_resource_definition_criteria" "account-config-gcp_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.account-config-gcp.id
  res_id                 = "gcp-account"
}
