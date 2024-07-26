resource "humanitec_resource_definition" "s3-co-provision" {
  driver_type    = "humanitec/terraform"
  id             = "s3-co-provision"
  name           = "s3-co-provision"
  type           = "s3"
  driver_account = "aws"
  driver_inputs = {
    values_string = jsonencode({
      "variables" = {
        "REGION" = "eu-central-1"
      }
      "credentials_config" = {
        "variables" = {
          "ACCESS_KEY_ID"    = "AccessKeyId"
          "ACCESS_KEY_VALUE" = "SecretAccessKey"
        }
      }
      "script" = "# This provider block is using the Terraform variables\n# set through the credentials_config.\n# Variable declarations omitted for brevity.\nprovider \"aws\" {\n  region     = var.REGION\n  access_key = var.ACCESS_KEY_ID\n  secret_key = var.ACCESS_KEY_VALUE\n}\n\n# ... Terraform code reduced for brevity\n\nresource \"aws_s3_bucket\" \"bucket\" {\n  bucket = my-bucket\n}\n\noutput \"bucket\" {\n  value = aws_s3_bucket.main.id\n}\n\noutput \"arn\" {\n  value = aws_s3_bucket.main.arn\n}\n  \noutput \"region\" {\n  value = aws_s3_bucket.main.region\n}"
    })
  }

  provision = {
    "aws-policy" = {
      is_dependent = false
    }
  }
}

