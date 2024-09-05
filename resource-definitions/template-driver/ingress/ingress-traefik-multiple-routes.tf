resource "humanitec_resource_definition" "traefik-ingress-eg" {
  driver_type = "humanitec/template"
  id          = "traefik-ingress-eg"
  name        = "traefik-ingress-eg"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "routeHosts"    = "$${resources.dns<route.outputs.host}"
      "routePaths"    = "$${resources.dns<route.outputs.path}"
      "routePorts"    = "$${resources.dns<route.outputs.port}"
      "routeServices" = "$${resources.dns<route.outputs.service}"
      "templates" = {
        "init"      = <<END_OF_TEXT
host: {{ .resource.host | quote }}
# ingress paths are added implicitely to our ingress resource based on the contents of our workload. These are an older
# alternative to route resources. Consider this deprecated in the future!
ingressPaths: {{ dig  "rules" "http" (list) .resource | toRawJson }}
# The tls secret name could be generated by Humanitec or injected as an input parameter to our ingress.
tlsSecretName: {{ .driver.values.tls_secret_name | default .resource.tls_secret_name | default .driver.values.automatic_tls_secret_name | quote }}
{{- if eq (lower ( .driver.values.path_type | default "Prefix")) "exact" -}}
defaultMatchRule: Path
{{- else }}
defaultMatchRule: PathPrefix
{{- end }}
END_OF_TEXT
        "manifests" = <<END_OF_TEXT
# Create our single manifest with many routes in it. Alternative configurations could create a manifest per route with unique file names if required.
ingressroute.yaml:
  location: namespace
  data:
    apiVersion: traefik.io/v1alpha1
    kind: IngressRoute
    metadata:
      # id is the unique resource uuid for this ingress
      name: {{ .id }}-ingressroute
      annotations:
        {{- range $k, $v := .driver.values.annotations }}
        {{ $k | toRawJson }}: {{ $v | toRawJson }}
        {{- end }}
      labels:
        {{- range $k, $v := .driver.values.labels }}
        {{ $k | toRawJson }}: {{ $v | toRawJson }}
        {{- end }}
    spec:
      entryPoints:
        - websecure
      routes:
        # Add all the paths from the dependent route resources. Route resources can have different hostnames but will all obey the path type set out in the resource inputs.
        {{- range $index, $path := .driver.values.routePaths }}
        - match: Host(`{{ index $.driver.values.routeHosts $index }}`) && {{ $.init.defaultMatchRule }}(`{{ $path }}`)
          kind: Rule
          services:
            - kind: Service
              name: {{ index $.driver.values.routeServices $index | toRawJson }}
              port: {{ index $.driver.values.routePorts $index }}
        {{- end }}
        
        # Add all the support ingress paths. The old style ingress rules use a single hostname coming from the resource configuration but support different path types per rule.
        # As mentioned further up, consider these deprecated in the future!
        {{- range $path, $rule := .init.ingressPaths }}
        {{ $lcType := lower $rule.type -}}
        {{- if eq $lcType "implementationspecific" -}}
        - match: Host(`{{ $.init.host }}`) && Path(`{{ $path }}`)
        {{- else if eq $lcType "exact" -}}
        - match: Host(`{{ $.init.host }}`) && Path(`{{ $path }}`)
        {{ else }}
        - match: Host(`{{ $.init.host }}`) && PathPrefix(`{{ $path }}`)
        {{- end }}
          kind: Rule
          services:
          - kind: Service
            name: {{ $rule.name | quote }}
            port: {{ $rule.port }}
        {{- end }}
      {{- if not (or .driver.values.no_tls (eq .init.tlsSecretName "")) }}
      tls:
        secretName: {{ .init.tlsSecretName | toRawJson }}
      {{- end }}
END_OF_TEXT
      }
    })
  }
}
