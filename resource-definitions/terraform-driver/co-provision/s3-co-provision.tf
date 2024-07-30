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

resource "aws_s3_bucket" "bucket" {
  bucket = my-bucket
}

output "bucket" {
  value = aws_s3_bucket.main.id
}

output "arn" {
  value = aws_s3_bucket.main.arn
}
  
output "region" {
  value = aws_s3_bucket.main.region
}
END_OF_TEXT
    })
  }

  provision = {
    "aws-policy" = {
      is_dependent = false
    }
  }
}

