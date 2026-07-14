resource "humanitec_resource_definition" "s3-opentofu-container-runner" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "s3-opentofu-container-runner"
  name           = "S3 Bucket"
  type           = "s3"
  driver_account = "$${resources['config.default#tf-config'].account}"
  driver_inputs = {
    values_string = jsonencode({
      "runner" = {
        "pod_template" = <<END_OF_TEXT
spec:
  imagePullSecrets:
    - name: ghcr-private-registry
END_OF_TEXT
      }
      "source" = {
        "ref"      = "refs/tags/v1.2.3"
        "url"      = "https://my-domain.com/my-org/my-repo.git"
        "username" = "my-git-handler"
        "path"     = "path/to/s3"
      }
      "variables" = {
        "bucket" = "$${context.app.id}-$${context.env.id}"
      }
      "credentials_config" = {
        "environment" = {
          "AWS_ACCESS_KEY_ID"     = "AccessKeyId"
          "AWS_SECRET_ACCESS_KEY" = "SecretAccessKey"
          "AWS_SESSION_TOKEN"     = "SessionToken"
        }
      }
      "use_default_backend" = false
      "files" = {
        "backend.tf"         = <<END_OF_TEXT
terraform {
  backend "s3" {
    # Read backend configuration values from the "tf-config" resource
    bucket = "$${resources['config.default#tf-config'].outputs.backend_s3_bucket_name}"
    region = "$${resources['config.default#tf-config'].outputs.backend_s3_bucket_region}"
    # Use placeholders to construct a unique path and key for the state file
    key    = "$${context.org.id}/$${context.app.id}/$${context.env.id}/$${context.res.guresid}.tfstate"
  }
}
END_OF_TEXT
        "provider-config.tf" = <<END_OF_TEXT
provider "aws" {
  region = "$${resources['config.default#tf-config'].outputs.provider_aws_region}"
}
END_OF_TEXT
      }
    })
    secret_refs = jsonencode({
      "source" = {
        "password" = {
          "store" = "my-store"
          "ref"   = "path/to/git/password"
        }
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "s3-opentofu-container-runner_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.s3-opentofu-container-runner.id
  env_type               = "development"
}
