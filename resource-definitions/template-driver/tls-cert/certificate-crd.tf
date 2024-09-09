resource "humanitec_resource_definition" "certificate-crd" {
  driver_type = "humanitec/template"
  id          = "certificate-crd"
  name        = "certificate-crd"
  type        = "tls-cert"
  driver_inputs = {
    values_string = jsonencode({
      "templates" = {
        "init"      = <<END_OF_TEXT
tlsSecretName: {{ .id }}-tls
hostName: $${resources.dns.outputs.host}
certificateName: {{ .id }}-cert
END_OF_TEXT
        "manifests" = <<END_OF_TEXT
certificate-crd.yml:
  data:
    apiVersion: cert-manager.io/v1
    kind: Certificate
    metadata:
      name: {{ .init.certificateName }}
    spec:
      secretName: {{ .init.tlsSecretName }}
      duration: 2160h # 90d
      renewBefore: 720h # 30d
      isCA: false
      privateKey:
        algorithm: RSA
        encoding: PKCS1
        size: 2048
      usages:
        - server auth
        - client auth
      dnsNames:
        - {{ .init.hostName | toString | toRawJson }}
      # The name of the issuerRef must point to the issuer / clusterIssuer in your cluster
      issuerRef:
        name: letsencrypt-prod
        kind: ClusterIssuer
  location: namespace
END_OF_TEXT
        "outputs"   = "tls_secret_name: {{ .init.tlsSecretName }}\n"
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "certificate-crd_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.certificate-crd.id
  class                  = "default"
}
