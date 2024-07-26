resource "humanitec_resource_definition" "s3-backend-example" {
  driver_type = "humanitec/terraform"
  id          = "s3-backend-example"
  name        = "s3-backend-example"
  type        = "s3"
  driver_inputs = {
    values_string = jsonencode({
      "script" = "variable \"region\" {}\n\nterraform {\n  backend {\n    bucket = \"$${resources.config#tf-backend.outputs.bucket}\"\n    key    = \"$${resources.config#tf-backend.outputs.prefix}$${context.app.id}/$${context.env.id}/$${context.res.type}.$${context.res.class}/$${context.res.id}\"\n    region = \"$${resources.config#tf-backend.outputs.region}\"\n    shared_credentials_files = [\"backend_creds\"]\n  }\n\n  required_providers {\n    aws = {\n      source = \"hashicorp/aws\"\n    }\n  }\n}\n\nprovider \"aws\" {\n  region     = var.region\n\n  # The file is defined above. The provide will read the creds from this file.\n  shared_credentials_files = [\"aws_creds\"]\n}\n\noutput \"bucket\" {\n  value = aws_s3_bucket.bucket.bucket\n}\n\noutput \"region\" {\n  value = var.region\n}\n\nresource \"aws_s3_bucket\" \"bucket\" {\n  bucket = \"$\\{replace(\"$${context.res.id}\", \"^.*\\.\", \"\")}-standard-$${context.env.id}-$${context.app.id}-$${context.org.id}\"\n  tags = {\n    Humanitec = true\n  }\n}"
      "variables" = {
        "region" = "us-east-1"
      }
    })
    secret_refs = jsonencode({
      "files" = {
        "aws_creds" = {
          "value" = "$${resources.config#aws-account.outputs.credentials_file}"
        }
        "backend_creds" = {
          "value" = "$${resources.config#tf-backend.outputs.credentials_file}"
        }
      }
    })
  }
}


