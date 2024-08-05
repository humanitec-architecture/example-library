resource "humanitec_resource_definition" "ambassador-ingress" {
  driver_type = "template"
  id          = "ambassador-ingress"
  name        = "ambassador-ingress"
  type        = "ingress"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = <<END_OF_TEXT
name: {{ .id }}-ingress
secretname: $${resources.tls-cert.outputs.tls_secret_name}
host: $${resources.dns.outputs.host}
namespace: $${resources['k8s-namespace#k8s-namespace'].outputs.namespace}
END_OF_TEXT
        "manifests" = <<END_OF_TEXT
ambassador-mapping.yaml:
  data:
    apiVersion: getambassador.io/v3alpha1
    kind: Mapping
    metadata:
      name: {{ .init.name }}-mapping
    spec:
      host: {{ .init.host }}
      prefix: /
      service: my-service-name:8080
  location: namespace
ambassador-tlscontext.yaml:
  data:
    apiVersion: getambassador.io/v3alpha1
    kind: TLSContext
    metadata:
      name: {{ .init.name }}-tlscontext
    spec:
      hosts:
        - {{ .init.host }}
      secret: {{ .init.secretname }}
  location: namespace
END_OF_TEXT
      }
    })
  }
}

