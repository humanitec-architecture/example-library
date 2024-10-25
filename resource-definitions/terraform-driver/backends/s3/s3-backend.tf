resource "humanitec_resource_definition" "example-terraform-s3-backend-s3" {
  driver_type    = "humanitec/terraform"
  id             = "example-terraform-s3-backend-s3"
  name           = "s3-backend-example"
  type           = "s3"
  driver_account = "$${resources.config#tf-backend.account}"
  driver_inputs = {
    values_string = jsonencode({
      "credentials_config" = {
        "environment" = {
          "AWS_ACCESS_KEY_ID"     = "AccessKeyId"
          "AWS_SECRET_ACCESS_KEY" = "SecretAccessKey"
          "AWS_SESSION_TOKEN"     = "SessionToken"
        }
      }
      "script" = <<END_OF_TEXT
terraform {
  backend "s3" {
    bucket = "$${resources.config#tf-backend.outputs.bucket}"
    key    = "$${resources.config#tf-backend.outputs.prefix}$${context.app.id}/$${context.env.id}/$${context.res.type}.$${context.res.class}/$${context.res.id}"
    region = "$${resources.config#tf-backend.outputs.region}"
  }
}

resource "random_id" "thing" {
  byte_length = 8
}

output "bucket" {
  value = "$\{random_id.thing.hex}"
}
END_OF_TEXT
    })
  }
}


