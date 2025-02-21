resource "humanitec_resource_definition" "custom-workload-with-initcontainer" {
  driver_type = "humanitec/template"
  id             = "custom-workload-with-initcontainer"
  name           = "custom-workload-with-initcontainer"
  type           = "workload"
  driver_inputs  = {
    values_string  = jsonencode({
      "templates" = {
        "outputs" = <<END_OF_TEXT
update: 
- op: add
  path: /spec/pod/initContainers
  value:
  - command:
    - sh
    - -c
    - until nslookup myservice.$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace).svc.cluster.local; do echo waiting for myservice; sleep 2; done
    image: busybox
    name: init-myservice
END_OF_TEXT
      }
    })
  }
}

resource "humanitec_resource_definition_criteria" "custom-workload-with-initcontainer_criteria_0" {
  resource_definition_id = resource.humanitec_resource_definition.custom-workload-with-initcontainer.id 
  app_id = "my-app"
}
