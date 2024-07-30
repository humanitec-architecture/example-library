resource "humanitec_resource_definition" "aws-policy-co-provision" {
  driver_type = "humanitec/terraform"
  id             = "aws-policy-co-provision"
  name           = "aws-policy-co-provision"
  type           = "aws-policy"
  driver_account = "aws"
  driver_inputs  = {
    values_string  = jsonencode({
      "variables" = {
        "REGION" = "$${resources.s3.outputs.region}"
        "BUCKET" = "$${resources.s3.outputs.bucket}"
        "BUCKET_ARN" = "$${resources.s3.outputs.arn}"
      }
      "credentials_config" = {
        "variables" = {
          "ACCESS_KEY_ID" = "AccessKeyId"
          "ACCESS_KEY_VALUE" = "SecretAccessKey"
        }
      }
      "script" = <<END_OF_TEXT
# This provider block is using the Terraform variables
# set through the credentials_config.
# Variable declarations omitted for brevity.
provider "aws" {
  region     = var.REGION
  access_key = var.ACCESS_KEY_ID
  secret_key = var.ACCESS_KEY_VALUE
}

# ... Terraform code reduced for brevity

resource "aws_iam_policy" "bucket" {
  name        = "$${var.BUCKET}-policy"
  policy      = data.aws_iam_policy_document.main.json
}

data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      var.BUCKET_ARN,
    ]
  }
}
END_OF_TEXT
    })
  }
}

