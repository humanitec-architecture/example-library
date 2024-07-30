resource "humanitec_resource_definition" "account-config-aws" {
  driver_type = "humanitec/echo"
  id             = "account-config-aws"
  name           = "account-config-aws"
  type           = "config"
  driver_account = "aws-credentials"
  driver_inputs  = {
    values_string  = jsonencode({
      "region" = "us-east-1"
    })
  }
}

resource "humanitec_resource_definition_criteria" "account-config-aws_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.account-config-aws.id 
  res_id = "aws-account"
}
