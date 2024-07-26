resource "humanitec_resource_definition" "aws-policy-co-provision" {
  driver_type    = "humanitec/terraform"
  id             = "aws-policy-co-provision"
  name           = "aws-policy-co-provision"
  type           = "aws-policy"
  driver_account = "aws"
  driver_inputs = {
    values_string = jsonencode({
      "variables" = {
        "REGION"     = "$${resources.s3.outputs.region}"
        "BUCKET"     = "$${resources.s3.outputs.bucket}"
        "BUCKET_ARN" = "$${resources.s3.outputs.arn}"
      }
      "credentials_config" = {
        "variables" = {
          "ACCESS_KEY_ID"    = "AccessKeyId"
          "ACCESS_KEY_VALUE" = "SecretAccessKey"
        }
      }
      "script" = "# This provider block is using the Terraform variables\n# set through the credentials_config.\n# Variable declarations omitted for brevity.\nprovider \"aws\" {\n  region     = var.REGION\n  access_key = var.ACCESS_KEY_ID\n  secret_key = var.ACCESS_KEY_VALUE\n}\n\n# ... Terraform code reduced for brevity\n\nresource \"aws_iam_policy\" \"bucket\" {\n  name        = \"$${var.BUCKET}-policy\"\n  policy      = data.aws_iam_policy_document.main.json\n}\n\ndata \"aws_iam_policy_document\" \"main\" {\n  statement {\n    effect = \"Allow\"\n\n    actions = [\n      \"s3:GetObject\",\n      \"s3:ListBucket\",\n    ]\n\n    resources = [\n      var.BUCKET_ARN,\n    ]\n  }\n}"
    })
  }
}

