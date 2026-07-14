resource "humanitec_resource_definition" "config_tf_development" {
  driver_type    = "humanitec/echo"
  id             = "config_tf_development"
  name           = "tf-config-development"
  type           = "config"
  driver_account = "my-cloud-account-id"
  driver_inputs = {
    values_string = jsonencode({
      "provider_aws_region"      = "us-east-1"
      "backend_s3_bucket_name"   = "my-s3-backend-bucket"
      "backend_s3_bucket_region" = "us-east-1"
    })
  }
}

resource "humanitec_resource_definition_criteria" "config_tf_development_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.config_tf_development.id
  env_type               = "development"
  res_id                 = "tf-config"
  class                  = "default"
}
