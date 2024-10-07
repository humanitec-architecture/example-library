resource "humanitec_resource_definition" "aws-policy-s3-read-only" {
  driver_type = "humanitec/echo"
  id          = "aws-policy-s3-read-only"
  name        = "aws-policy-s3-read-only"
  type        = "aws-policy"
  driver_inputs = {
    values_string = jsonencode({
      "arn" = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    })
  }
}

resource "humanitec_resource_definition_criteria" "aws-policy-s3-read-only_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.aws-policy-s3-read-only.id
  app_id                 = "example-delegator"
  class                  = "s3-read-only"
}
