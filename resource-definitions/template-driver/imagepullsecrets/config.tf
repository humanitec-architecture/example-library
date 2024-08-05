resource "humanitec_resource_definition" "regcred-config" {
  driver_type = "humanitec/template"
  id          = "regcred-config"
  name        = "regcred-config"
  type        = "config"
  driver_inputs = {
    values_string = jsonencode({
      "secret_name" = "regcred"
      "server"      = "FIXME"
      "templates" = {
        "init" = <<END_OF_TEXT
dockerConfigJson:
  auths:
    {{ .driver.values.server | quote }}:
      username: {{ .driver.secrets.username | toRawJson }}
      password: {{ .driver.secrets.password | toRawJson }}
END_OF_TEXT
        "manifests" = {
          "regcred-secret.yaml" = {
            "data"     = <<END_OF_TEXT
apiVersion: v1
kind: Secret
metadata:
  name: {{ .driver.values.secret_name }}
data:
  .dockerconfigjson: {{ .init.dockerConfigJson | toRawJson | b64enc }}
type: kubernetes.io/dockerconfigjson
END_OF_TEXT
            "location" = "namespace"
          }
        }
        "outputs" = "secret_name: {{ .driver.values.secret_name }}\n"
      }
    })
    secret_refs = jsonencode({
      "password" = {
        "ref"   = "regcred-password"
        "store" = "FIXME"
      }
      "username" = {
        "ref"   = "regcred-username"
        "store" = "FIXME"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "regcred-config_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.regcred-config.id
  class                  = "default"
  res_id                 = "regcred"
}
