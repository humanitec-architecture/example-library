resource "humanitec_resource_definition" "s3-dynamic-credentials" {
  driver_type    = "humanitec/terraform"
  id             = "s3-dynamic-credentials"
  name           = "s3-dynamic-credentials"
  type           = "s3"
  driver_account = "aws-temp-creds"
  driver_inputs = {
    values_string = jsonencode({
      "variables" = {
        "REGION" = "eu-central-1"
      }
      "credentials_config" = {
        "variables" = {
          "ACCESS_KEY_ID"    = "AccessKeyId"
          "ACCESS_KEY_VALUE" = "SecretAccessKey"
          "SESSION_TOKEN"    = "SessionToken"
        }
      }
      "script" = "# This provider block is using the Terraform variables\n# set through the credentials_config.\n# Variable declarations omitted for brevity.\nprovider \"aws\" {\n  region     = var.REGION\n  access_key = var.ACCESS_KEY_ID\n  secret_key = var.ACCESS_KEY_VALUE\n  token      = var.SESSION_TOKEN\n}\n\n# ... Terraform code reduced for brevity\n\nresource \"aws_s3_bucket\" \"bucket\" {\n  bucket = my-bucket\n}"
    })
  }
}

