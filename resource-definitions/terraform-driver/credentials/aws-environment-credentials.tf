resource "humanitec_resource_definition" "aws-environment-credentials" {
  driver_type    = "humanitec/terraform"
  id             = "aws-environment-credentials"
  name           = "aws-environment-credentials"
  type           = "s3"
  driver_account = "$${resources['config.default#aws-account'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "credentials_config" = {
        "environment" = {
          "AWS_ACCESS_KEY_ID"     = "AccessKeyId"
          "AWS_SECRET_ACCESS_KEY" = "SecretAccessKey"
          "AWS_SESSION_TOKEN"     = "SessionToken"
        }
      }
      "script" = "\nvariable \"region\" {}\n\nterraform {\n  required_providers {\n    aws = {\n      source = \"hashicorp/aws\"\n    }\n  }\n}\n\nprovider \"aws\" {\n  region = var.region\n}\n\noutput \"bucket\" {\n  value = aws_s3_bucket.bucket.bucket\n}\n\noutput \"region\" {\n  value = var.region\n}\n\nresource \"aws_s3_bucket\" \"bucket\" {\n  bucket = \"$\\{replace(\"$${context.res.id}\", \"/^.*\\\\./\", \"\")}-standard-$${context.env.id}-$${context.app.id}-$${context.org.id}\"\n  tags = {\n    Humanitec = true\n  }\n}"
      "variables" = {
        "region" = "$${resources['config.default#aws-account'].outputs.region}"
      }
    })
  }
}


