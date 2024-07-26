resource "humanitec_resource_definition" "aws-provider-credentials" {
  driver_type    = "humanitec/terraform"
  id             = "aws-provider-credentials"
  name           = "aws-provider-credentials"
  type           = "s3"
  driver_account = "$${resources['config.default#aws-account'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "credentials_config" = {
        "variables" = {
          "access_key_id"     = "AccessKeyId"
          "secret_access_key" = "SecretAccessKey"
          "session_token"     = "SessionToken"
        }
      }
      "script" = "\nvariable \"access_key_id\" {\n  sensitive = true\n}\nvariable \"secret_access_key\" {\n  sensitive = true\n}\nvariable \"session_token\" {\n  sensitive = true\n}\nvariable \"region\" {}\n\nterraform {\n  required_providers {\n    aws = {\n      source = \"hashicorp/aws\"\n    }\n  }\n}\n\nprovider \"aws\" {\n  region     = var.region\n  access_key = var.access_key_id\n  secret_key = var.secret_access_key\n  token      = var.session_token\n}\n\noutput \"bucket\" {\n  value = aws_s3_bucket.bucket.bucket\n}\n\noutput \"region\" {\n  value = var.region\n}\n\nresource \"aws_s3_bucket\" \"bucket\" {\n  bucket = \"$\\{replace(\"$${context.res.id}\", \"/^.*\\\\./\", \"\")}-standard-$${context.env.id}-$${context.app.id}-$${context.org.id}\"\n  tags = {\n    Humanitec = true\n  }\n}"
      "variables" = {
        "region" = "$${resources['config.default#aws-account'].outputs.region}"
      }
    })
  }
}


