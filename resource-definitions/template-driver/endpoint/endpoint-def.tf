resource "humanitec_resource_definition" "endpoint-example-endpoint" {
  driver_type = "humanitec/template"
  id          = "endpoint-example-endpoint"
  name        = "endpoint-example-endpoint"
  type        = "endpoint"
  driver_inputs = {
    values_string = jsonencode({
      "host" = "example.com"
      "port" = 8080
      "templates" = {
        "init"    = <<END_OF_TEXT
{{- $username := .driver.secrets.username | default "" }}
{{- $password := .driver.secrets.password | default "" }}
username: {{ $username | toRawJson }}
password: {{ $password | toRawJson }}
userinfo: {{ if $username }}
  {{- $username }}:
  {{- end }}
  {{- $password }}
hostport: {{ .driver.values.host }}
  {{- if .driver.values.port -}}
    :{{ .driver.values.port }}
  {{- end }}
END_OF_TEXT
        "outputs" = <<END_OF_TEXT
scheme: {{ .driver.values.scheme | default "http" }}
host: {{ .driver.values.host }}
port: {{ .driver.values.port }}
path: {{ .driver.values.path | default "" | toRawJson }}
query: {{ .driver.values.query | default "" | toRawJson }}
fragment: {{ .driver.values.fragment | default "" | toRawJson }}
END_OF_TEXT
        "secrets" = <<END_OF_TEXT
username: {{ .init.username | toRawJson }}
password: {{ .init.password | toRawJson }}
url: {{ .outputs.values | merge (dict "userinfo" (.init.userinfo | default "") "host" .init.hostport) | urlJoin | toRawJson }}
END_OF_TEXT
      }
    })
  }
}

