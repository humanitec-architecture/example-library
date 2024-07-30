resource "humanitec_resource_definition" "aci-workload" {
  driver_type = "humanitec/template"
  id             = "aci-workload"
  name           = "aci-workload"
  type           = "workload"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update: 
- op: add
  path: /spec/tolerations
  value:
  - key: "virtual-kubelet.io/provider"
    operator: "Exists"
  - key: "azure.com/aci"
    effect: "NoSchedule"
- op: add
  path: /spec/nodeSelector
  value:
    kubernetes.io/role: agent
    beta.kubernetes.io/os: linux
    type: virtual-kubelet
END_OF_TEXT
      }
    })
  }
}


