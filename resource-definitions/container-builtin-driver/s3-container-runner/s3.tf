resource "humanitec_resource_definition" "container-builtin-s3" {
  driver_type = "humanitec/container-builtin"
  id          = "container-builtin-s3"
  name        = "container-builtin-s3"
  type        = "s3"
  driver_inputs = {
    values_string = jsonencode({
      "job" = {
        "image"            = "ghcr.io/humanitec-architecture/s3-container-runner:0.1.0"
        "namespace"        = "humanitec-runner"
        "service_account"  = "humanitec-runner"
        "shared_directory" = "/home/runner/workspace"
        "variables" = {
          "AWS_REGION" = "eu-west-1"
        }
      }
      "templates" = {
        "init"  = <<END_OF_TEXT
{{- if and $.state (hasKey $.state "bucket") }}
bucket: {{ $.state.bucket }}
{{- else }}
bucket: hum-{{ randAlphaNum 20 | lower }}
{{- end }}
END_OF_TEXT
        "state" = "bucket: {{ $.init.bucket }}\n"
        "outputs" = {
          "job" = <<END_OF_TEXT
{{- $job := deepCopy $.driver.values.job -}}
{{- $_ := set $job.variables "BUCKET_NAME" $.init.bucket -}}
{{ $job | toRawJson }}
END_OF_TEXT
        }
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "container-builtin-s3_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.container-builtin-s3.id
  class                  = "default"
}
