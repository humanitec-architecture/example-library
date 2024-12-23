resource "humanitec_resource_definition" "traefik-ingress" {
  driver_type = "humanitec/template"
  id          = "traefik-ingress"
  name        = "traefik-ingress"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = <<END_OF_TEXT
name: {{ .id }}-ir
secretname: $${resources.tls-cert.outputs.tls_secret_name}
host: $${resources.dns.outputs.host}
namespace: $${resources['k8s-namespace#k8s-namespace'].outputs.namespace}
END_OF_TEXT
        "manifests" = <<END_OF_TEXT
traefik-ingressroute.yaml:
  data:
    apiVersion: traefik.io/v1alpha1
    kind: IngressRoute
    metadata:
      name: {{ .init.name }}
    spec:
      routes:
      - match: Host(`{{ .init.host }}`) && PathPrefix(`/`)
        kind: Rule
        services:
        - name: my-service-name
          kind: Service
          port: 8080
          namespace: {{ .init.namespace }} 
      tls:
        secretName: {{ .init.secretname }}
  location: namespace
END_OF_TEXT
      }
    })
  }
}

