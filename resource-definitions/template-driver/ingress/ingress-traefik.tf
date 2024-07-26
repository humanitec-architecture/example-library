resource "humanitec_resource_definition" "traefik-ingress" {
  driver_type = "template"
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
        "manifests" = "traefik-ingressroute.yaml:\n  data:\n    apiVersion: traefik.io/v1alpha1\n    kind: IngressRoute\n    metadata:\n      name: {{ .init.name }}\n    spec:\n      routes:\n      - match: Host(`{{ .init.host }}`) && PathPrefix(`/`)\n        kind: Rule\n        services:\n        - name: my-service-name\n          kind: Service\n          port: 8080\n          namespace: {{ .init.namespace }} \n      tls:\n        secretName: {{ .init.secretname }}\n  location: namespace"
      }
    })
  }
}

