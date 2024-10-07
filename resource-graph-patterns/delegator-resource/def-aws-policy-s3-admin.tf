resource "humanitec_resource_definition" "aws-policy-s3-admin" {
  driver_type = "humanitec/echo"
  id          = "aws-policy-s3-admin"
  name        = "aws-policy-s3-admin"
  type        = "aws-policy"
  driver_inputs = {
    values_string = jsonencode({
      "arn" = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    })
  }
}

resource "humanitec_resource_definition_criteria" "aws-policy-s3-admin_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.aws-policy-s3-admin.id
  app_id                 = "example-delegator"
  class                  = "s3-admin"
}
