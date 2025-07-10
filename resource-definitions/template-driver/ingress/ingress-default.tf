resource "humanitec_resource_definition" "default-ingress" {
  driver_type = "humanitec/template"
  id          = "default-ingress"
  name        = "default-ingress"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "manifests" = <<END_OF_TEXT
{{- /*
  Only generate an ingress manifest if there are any routes defined.
*/ -}}
{{- if gt (len .driver.values.routePaths ) 0 -}}
ingress.yaml:
  location: namespace
  data:
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      {{- if hasKey .driver.values "annotations" }}
      annotations:
        {{- range $k, $v := .driver.values.annotations }}
        {{ $k | quote }}: {{ $v | quote }}
        {{- end}}
      {{- end}}
      {{- if hasKey .driver.values "labels" }}
      labels:
        {{- range $k, $v := .driver.values.labels }}
        {{ $k | quote }}: {{ $v | quote }}
        {{- end}}
      {{- end}}
      name: {{ .id }}-ingress
    spec:
      {{- if .driver.values.class }}
      ingressClassName: {{ .driver.values.class | quote }}
      {{- end }}
      rules:
      - host: {{ .driver.values.host | quote }}
        http:
          paths:
          {{- /*
            We are guaranteed that .driver.values.routePaths is non-zero in
            length from the top level if statement, so we don't need
            to deal with the empty condition.
          */ -}}
          {{- range $index, $path := .driver.values.routePaths }}
          - path: {{ $path | quote }}
            pathType: {{ $.driver.values.path_type | default "Prefix" | quote }}
            backend:
              service:
                name: {{ index $.driver.values.routeServices $index  | quote }}
                port:
                  number: {{ index $.driver.values.routePorts $index }}
          {{- end }}
      tls:
      - hosts:
        - {{ .driver.values.host | quote }}
        secretName: {{ .driver.values.tlsSecretName | quote }}
{{- end -}}
END_OF_TEXT
        "outputs"   = "id: {{ .id }}-ingress\n"
      }
      "host"          = "$${resources.dns.outputs.host}"
      "routePaths"    = "$${resources.dns<route.outputs.path}"
      "routePorts"    = "$${resources.dns<route.outputs.port}"
      "routeServices" = "$${resources.dns<route.outputs.service}"
      "tlsSecretName" = "$${resources.tls-cert.outputs.tls_secret_name}"
    })
  }
}

