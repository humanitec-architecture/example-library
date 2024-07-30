resource "humanitec_resource_definition" "ambassador-ingress" {
  driver_type = "template"
  id             = "ambassador-ingress"
  name           = "ambassador-ingress"
  type           = "ingress"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "init" = <<END_OF_TEXT
name: {{ .id }}-ingress
secretname: $${resources.tls-cert.outputs.tls_secret_name}
host: $${resources.dns.outputs.host}
namespace: $${resources['k8s-namespace#k8s-namespace'].outputs.namespace}
END_OF_TEXT
        "manifests" = "ambassador-mapping.yaml:\n  data:\n    apiVersion: getambassador.io/v3alpha1\n    kind: Mapping\n    metadata:\n      name: {{ .init.name }}-mapping\n    spec:\n      host: {{ .init.host }}\n      prefix: /\n      service: my-service-name:8080\n  location: namespace\nambassador-tlscontext.yaml:\n  data:\n    apiVersion: getambassador.io/v3alpha1\n    kind: TLSContext\n    metadata:\n      name: {{ .init.name }}-tlscontext\n    spec:\n      hosts:\n        - {{ .init.host }}\n      secret: {{ .init.secretname }}\n  location: namespace"
      }
    })
  }
}

