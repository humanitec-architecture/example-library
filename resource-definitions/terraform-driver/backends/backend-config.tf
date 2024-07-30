resource "humanitec_resource_definition" "tf-backend-config" {
  driver_type    = "humanitec/template"
  id             = "tf-backend-config"
  name           = "tf-backend-config"
  type           = "config"
  driver_account = "aws-credentials"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
bucket: my-terraform-state-bucket
key_prefix:  "tf-state/"
region: us-east-1
END_OF_TEXT
        "secrets" = <<END_OF_TEXT
credentials_file: |
  [default]
  aws_access_key_id = {{ .driver.secrets.account.aws_access_key_id }}
  aws_secret_access_key = {{ .driver.secrets.account.aws_secret_access_key }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "tf-backend-config_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.tf-backend-config.id
  res_id                 = "tf-backend"
}
