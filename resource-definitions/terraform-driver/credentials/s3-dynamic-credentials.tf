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
      "script" = <<END_OF_TEXT
# This provider block is using the Terraform variables
# set through the credentials_config.
# Variable declarations omitted for brevity.
provider "aws" {
  region     = var.REGION
  access_key = var.ACCESS_KEY_ID
  secret_key = var.ACCESS_KEY_VALUE
  token      = var.SESSION_TOKEN
}

# ... Terraform code reduced for brevity

resource "aws_s3_bucket" "bucket" {
  bucket = my-bucket
}
END_OF_TEXT
    })
  }
}

