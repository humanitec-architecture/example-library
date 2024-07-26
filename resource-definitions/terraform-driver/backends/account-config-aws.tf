resource "humanitec_resource_definition" "account-config-aws" {
  driver_type    = "humanitec/template"
  id             = "account-config-aws"
  name           = "account-config-aws"
  type           = "config"
  driver_account = "aws-credentials"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "secrets" = <<END_OF_TEXT
aws_access_key_id: {{ .driver.secrets.account.aws_access_key_id }}
aws_secret_access_key: {{ .driver.secrets.account.aws_secret_access_key }}
credentials_file: |
  [default]
  aws_access_key_id = {{ .driver.secrets.account.aws_access_key_id }}
  aws_secret_access_key = {{ .driver.secrets.account.aws_secret_access_key }}
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "account-config-aws_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.account-config-aws.id
  res_id                 = "aws-account"
}
