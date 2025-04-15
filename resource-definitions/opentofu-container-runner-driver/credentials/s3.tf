resource "humanitec_resource_definition" "s3-opentofu-container-runner" {
  driver_type    = "humanitec/opentofu-container-runner"
  id             = "s3-opentofu-container-runner"
  name           = "S3 Bucket"
  type           = "s3"
  driver_account = "my-aws-account"
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
        "ref"      = "refs/heads/main"
        "url"      = "https://my-domain.com/my-org/my-repo.git"
        "username" = "my-git-handler"
        "path"     = "path/to/s3"
      }
      "variables" = {
        "bucket" = "$${context.app.id}-$${context.env.id}"
        "region" = "eu-west-3"
      }
      "credentials_config" = {
        "environment" = {
          "AWS_ACCESS_KEY_ID"     = "AccessKeyId"
          "AWS_SECRET_ACCESS_KEY" = "SecretAccessKey"
        }
      }
      "use_default_backend" = false
      "files" = {
        "backend.tf" = <<END_OF_TEXT
terraform {
  backend "s3" {
    bucket = "my-s3-to-store-tf-state"
    key = "$${context.res.guresid}/state/terraform.tfstate"
    region = "eu-west-3"
  }
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
