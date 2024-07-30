resource "humanitec_resource_definition" "s3-backend-example" {
  driver_type = "humanitec/terraform"
  id             = "s3-backend-example"
  name           = "s3-backend-example"
  type           = "s3"
  driver_inputs  = {
    values_string  = jsonencode({
      "script" = <<END_OF_TEXT
variable "region" {}

terraform {
  backend {
    bucket = "$${resources.config#tf-backend.outputs.bucket}"
    key    = "$${resources.config#tf-backend.outputs.prefix}$${context.app.id}/$${context.env.id}/$${context.res.type}.$${context.res.class}/$${context.res.id}"
    region = "$${resources.config#tf-backend.outputs.region}"
    shared_credentials_files = ["backend_creds"]
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = var.region

  # The file is defined above. The provide will read the creds from this file.
  shared_credentials_files = ["aws_creds"]
}

output "bucket" {
  value = aws_s3_bucket.bucket.bucket
}

output "region" {
  value = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = "$\{replace("$${context.res.id}", "^.*\.", "")}-standard-$${context.env.id}-$${context.app.id}-$${context.org.id}"
  tags = {
    Humanitec = true
  }
}
END_OF_TEXT
      "variables" = {
        "region" = "us-east-1"
      }
    })
    secret_refs    = jsonencode({
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


